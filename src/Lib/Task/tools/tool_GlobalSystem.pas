unit tool_GlobalSystem;

interface
  type
    GlobalSystem = class
    public
      class function get_temp_path() : string;
      class function get_temp_file() : string;
    end;//class utility

implementation

{ GlobalSystem }
  uses
    //--[ common ]--
    sysUtils, windows
    ;

class function GlobalSystem.get_temp_file: string;
  const
    MAX_PATH = 255;
  var
    str : pchar;
begin
  str := StrAlloc( MAX_PATH );
  GetTempFileName( pChar( get_temp_path ), 'doc_',  0,  str );
  result := StrPas( str );
  StrDispose( str );
end;//func


class function GlobalSystem.get_temp_path: string;
  var
    path : string[255];
    len  : integer;
begin
  result := '';
  len := GetTempPath( 255, @path[1] );

  if( len > 0 )then
  begin
    setLength( path, len );
    result := path;
  end;//if
end;

end.
