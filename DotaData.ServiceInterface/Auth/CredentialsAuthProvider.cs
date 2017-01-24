using ServiceStack.ServiceInterface;
using ServiceStack.ServiceInterface.Auth;
using System;
using System.Collections.Generic;

namespace DotaData.ServiceInterface.Auth
{
    public class PUPCredentialsAuthProvider : CredentialsAuthProvider
    {
        public override bool TryAuthenticate(IServiceBase authService, string userName, string password)
        {
            return true;   
        }

        public override void OnAuthenticated(IServiceBase authService, IAuthSession session, IOAuthTokens tokens, Dictionary<string, string> authInfo)
        {
            session.CreatedAt = DateTime.UtcNow;
            session.IsAuthenticated = true;
            authService.SaveSession(session, SessionExpiry);  

            base.OnAuthenticated(authService, session, tokens, authInfo);
        }

    }

}