unit interface_userDataLoader;

interface
  uses
     //--[ common ]--
     adodb,
     //--[ interfaces ]--
     interface_userData,
     interface_userInfoLoader
     ;

  const
    IID_IUserDataLoader : TGUID = '{AD62CA51-2371-4FC5-8E4E-E5255B71F5F6}';

  type
    IUserDataLoader = interface( IUserInfoLoader )
                        ['{AD62CA51-2371-4FC5-8E4E-E5255B71F5F6}']
                        
      //--[ methods ]--
      function execute( nick, password : string ) : IUserData;overload;
    end;//interface


implementation

end.
 