// This is a shortened version of pcca-matrix's 'func.nut' file from the 'PCCA' layout
// Shamelessly copied by Yaron2019 :P
///////////////////////////////////////////////////////////////////////////////////////

function refresh_stats(system = "") {
    //fe.overlay.splash_message ("Counting games, please wait...")
    local datas = main_infos; local sys = "";local cnt;
    //local g_cnt = 0; 
	local g_time = 0; local g_played = 0; local dirs = {};
    dirs.results <- [];
    if(system != ""){ // Get games count for single system
        dirs.results.push( system );
    }else{ // Get games count for each system
        for ( local i = 0; i < fe.displays.len(); i++ ) dirs.results.push(fe.displays[i].name);
    }

    foreach(display in dirs.results){
        cnt=0;
        local romlist = "";
        for ( local i = 0; i < fe.displays.len(); i++ ){
            if(fe.displays[i].name == display){
                romlist = fe.displays[i].romlist;
                break;
            } 
        }
        if(romlist != ""){
            local text = txt.loadFile( FeConfigDirectory + "romlists/" + romlist + ".txt" );
            foreach( line in text.lines ) if( line != "" ) cnt++;
            datas[display] <- {"cnt":cnt-1, "pl":0, "time":0};
            //g_cnt+=cnt-1;
        }
    }

/*  marked out, not sure this is working properly
    // Get Stats for each System
    dirs = DirectoryListing( FeConfigDirectory + "stats", false );
    foreach(subdir in dirs.results){
        local files = DirectoryListing( FeConfigDirectory + "stats/" + subdir, false );
        if( !datas.rawin(subdir) ) datas[subdir] <- {"cnt":0, "pl":0, "time":0};
        foreach(file in files.results){
            if ( ext(file) == "stat" ){
                local f_stat = ReadTextFile(FeConfigDirectory + "stats/" + subdir + "/" + file);
                local i = 0;
                while ( !f_stat.eos() ) {
                    local num = f_stat.read_line().tointeger();
                    if(i){
                        datas[subdir].time+=num;
                        g_time+=num;
                    }else{
                        datas[subdir].pl+=num;
                        g_played+=num;
                    }
                    i++;
                }
            }
        }
    }
*/

    //datas["Main Menu"] <-{"cnt":g_cnt, "pl":g_played, "time":g_time};
    SaveStats(datas); // Save stats to file
    return datas;
}

function LoadStats(){
    local tabl = {};
    local f = ReadTextFile( FeConfigDirectory, "gtc.stats" );
    if( f._f.len() < 10 ) refresh_stats(); // if file is empty or too small to be complete (10 must be ok)
    while ( !f.eos() ) {
        local l = split( f.read_line(), ";");
        if( l.len() ) tabl[ l[0] ] <- {"cnt":l[1].tointeger(), "pl":l[2].tointeger(), "time":l[3].tointeger()}
    }
    return tabl;
}

function SaveStats(tbl){ // update global systems stats
    local f2 = file( FeConfigDirectory + "gtc.stats", "w" );
    foreach(k,d in tbl){
        local line = k + ";" + d.cnt + ";" + d.pl + ";" + d.time + "\n";
        local b = blob( line.len() );
        for (local i=0; i<line.len(); i++) b.writen( line[i], 'b' );
        f2.writeblob(b);
    }
}

// return directory listing
function get_dir_lists(path)
{
    local files = {};
    local temp = DirectoryListing( path, false );
    foreach ( t in temp.results )
    {
        local temp = strip_ext( t ).tolower();
        files[temp] <- path + "/" + t;
    }
    return files;
}

//Check if file exist
function file_exist(path)
{
    try { file(path, "r" ); return true; }
    catch( e ){ return false; }
}

//Round Number as decimal
function round(nbr, dec){
    local f = pow(10, dec) * 1.0;
    local newNbr = nbr * f;
    newNbr = floor(newNbr + 0.5)
    newNbr = (newNbr * 1.0) / f;
    return newNbr;
}

//Generate a pseudo-random integer between 0 and max
function rndint(max) {
    local roll = 1.0 * max * rand() / RAND_MAX;
    return roll.tointeger();
}

//get random index in a table
function get_random_table(tb){
    local i=0;
    local sel = rand()%tb.len();
    foreach( key, val in tb ){
        if(i == sel) return val
        i++;
    }
    return "";
}

//Select Random file in a folder
function get_random_file(dir){
    local fname = "";
    local tmp = zip_get_dir( dir );
    if( tmp.len() > 0 ) fname = dir + "/" + tmp[ rand()%tmp.len() ];
    return fname;
}

//Replace text in a string
function replace (string, original, replacement)
{
  local expression = regexp(original);
  local result = "";
  local position = 0;
  local captures = expression.capture(string);
  while (captures != null)
  {
    foreach (i, capture in captures)
    {
      result += string.slice(position, capture.begin);
      result += replacement;
      position = capture.end;
    }
    captures = expression.capture(string, position);
  }
  result += string.slice(position);
  return result;
}

//Return file ext
function ext( name )
{
    local s = split( name, "." );
    if ( s.len() <= 1 )
        return "";
    else
        return s[s.len()-1];
}

//Return filename without ext
function strip_ext( name )
{
    local s = split( name, "." );
    if ( s.len() == 1 )
        return name;
    else
    {
        local retval;
        retval = s[0];
        for ( local i=1; i<s.len()-1; i++ ) retval = retval + "." + s[i];
        return retval;
    }
}
