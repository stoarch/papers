unit interface_IProgressDisplayer;

interface
  const
    IID_IProgressDisplayer : TGUID = '{7963FBAB-C856-4BFB-A317-918A6722A59D}';

  type
    TProgressCancelationProcedure = procedure ( sender : Tobject ) of object;
    
  type
    IProgressDisplayer = interface
                       ['{7963FBAB-C856-4BFB-A317-918A6722A59D}']

      procedure show();
      procedure hide();
      
      procedure setTaskCaption( caption : string );
      procedure setTaskProgress( current, total : integer );
      procedure setSubTaskCaption( caption : string );
      procedure setSubTaskProgress( current, total : integer );

      procedure setCancelCallback( callback : TProgressCancelationProcedure );
    end;//interface

implementation

end.
 