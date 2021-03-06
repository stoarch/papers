unit interface_folderList;

interface
  uses
    //--[ common ]--
    classes,
    //--[ interfaces ]--
    interface_folder
    ;

  const
    IID_IFolderList : TGUID = '{1A8E1BEA-11E3-4BD6-9A3E-CD2157A79857}';

  type
    IFolderList = interface( IInterfaceList )
         ['{1A8E1BEA-11E3-4BD6-9A3E-CD2157A79857}']

      //--[ accessors ]--
      function get_active_folder() : integer;
      function get_folder( index : integer ) : IFolder;

      //--[ mutators ]--
      procedure set_active_folder( value : integer );
      procedure set_folder( index : integer; const value : IFolder );

      //--[ properties ]--
      property active_folder : integer read get_active_folder write set_active_folder;
      property folders[ index : integer ] : IFolder read get_folder write set_folder;
    end;//interface

implementation

end.
 