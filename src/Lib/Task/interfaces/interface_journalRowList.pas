unit interface_journalRowList;

interface
   uses
     //--[ common ]--
     classes,
     //--[ interfaces ]--
     interface_journalRow
     ;

   const
     IID_IJournalRowList : TGUID = '{008EE093-6166-4FE9-88B9-E58A7A47AA90}';

   type
     IJournalRowList = interface( IInterfaceList )
                     ['{008EE093-6166-4FE9-88B9-E58A7A47AA90}']
       //--[ accessors ]--
       function get_row( index : integer ) : IJournalRow;

       //--[ properties ]--
       property rows[ index : integer ] : IJournalRow read get_row;default;
       //--[ methods ]--
       procedure add( column : IJournalRow );overload;
     end;//interface


implementation

end.
 