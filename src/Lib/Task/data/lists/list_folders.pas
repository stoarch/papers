unit list_folders;

interface
  uses
    //--[ common ]--
    classes,
    //--[ interfaces ]--
    interface_folder,
    interface_folderList
    ;

  type
    TFolderList = class( TInterfaceList, IFolderList )
     private
       m_active_folder : integer;
     public
      //**[ IFolderList ]**
      //--[ accessors ]--
      function get_active_folder() : integer;
      function get_folder( index : integer ) : IFolder;

      //--[ mutators ]--
      procedure set_active_folder( value : integer );
      procedure set_folder( index : integer; const value : IFolder );

      //--[ properties ]--
      property active_folder : integer read get_active_folder write set_active_folder;
      property folders[ index : integer ] : IFolder read get_folder write set_folder;
    end;//class

implementation

{ TFolderList }

function TFolderList.get_active_folder: integer;
begin
  result := m_active_folder;
end;

function TFolderList.get_folder(index: integer): IFolder;
begin
  result := inherited Items[ index ] as IFolder;
end;

procedure TFolderList.set_active_folder(value: integer);
begin
  m_active_folder := value;
end;

procedure TFolderList.set_folder(index: integer; const value: IFolder);
begin
  inherited Items[ index ] := value;
end;

end.
 