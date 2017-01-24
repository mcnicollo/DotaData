using DotaData.ServiceInterface.Auth;
using ServiceStack.CacheAccess;
using ServiceStack.CacheAccess.Providers;
using ServiceStack.OrmLite;
using ServiceStack.ServiceInterface;
using ServiceStack.ServiceInterface.Auth;
using ServiceStack.ServiceInterface.Validation;
using ServiceStack.Text;
using ServiceStack.WebHost.Endpoints;
using System.Configuration;

namespace DotaData.ServiceHost
{
    public class AppHost : AppHostBase
    {

        public AppHost() : base("Dota Data Service Interface", typeof(DotaData.ServiceInterface.HeroService).Assembly) { }

        public override void Configure(Funq.Container container)
        {
            string dbConn = ConfigurationManager.ConnectionStrings["ORMLiteConnection"].ConnectionString;
            container.Register<IDbConnectionFactory>(new OrmLiteConnectionFactory(dbConn, SqlServerDialect.Provider));
            
            container.Register<ICacheClient>(new MemoryCacheClient());

            Plugins.Add(new AuthFeature(() => new DotaDataSession(), new IAuthProvider[] { new CredentialsAuthProvider() }));
            Plugins.Add(new ValidationFeature());

            JsConfig.IncludeNullValues = true;
        }
    }
}