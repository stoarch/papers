unit interface_documentDirectionsList;

interface
  uses //--[ common ]--
       classes,
       //--[ interfaces ]--
      interface_documentDirection
      ;

const
  IID_IDocumentDirectionsList : TGUID = '{FBDC8213-83A7-48CF-8BDB-69D03FEF86E6}';

type
  IDocumentDirectionsList = interface( IInterfaceList )
                        ['{FBDC8213-83A7-48CF-8BDB-69D03FEF86E6}']

      function GetDirections(index: integer): IDocumentDirection;
      procedure SetDirections(index: integer;  const Value: IDocumentDirection);

      //--[ property ]--
      property Directions[ index : integer ] : IDocumentDirection read GetDirections write SetDirections;default;

      //--[ methods ]--
      function indexOfUser( user_ind : integer ) : integer;
      function pipeByUser( user_ind : integer ) : integer;
      function userByPipe( pipe_ind : integer ) : integer;
  end;//interface
implementation

end.
 