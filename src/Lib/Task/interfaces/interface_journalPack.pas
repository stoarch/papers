unit interface_journalPack;

interface
  uses
    //--[ common ]--
    classes,
    //--[ interfaces ]--
    interface_journal
    ;

  const
    IID_IJournalPack : TGUID = '{26AB0FDA-D535-4046-8658-DA9B228A7BD3}';

  type
    IJournalPack = interface( IInterfaceList )
      //--[ accessors ]--
      function get_journal( index : integer ) : IJournal;

      //--[ mutators ]--
      procedure set_journal( index : integer; journal : IJournal );
      
      //--[ properties ]--
      property journals[ index : integer ] : IJournal read get_journal write set_journal; default;
    end;//interface


implementation

end.
 