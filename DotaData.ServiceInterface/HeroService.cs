using DotaData.ServiceModel;
using DotaData.ServiceModel.Types;
using ServiceStack.Common;
using ServiceStack.Common.Web;
using ServiceStack.OrmLite;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;

namespace DotaData.ServiceInterface
{
    public class HeroService : ServiceBase
    {
       // [Authenticate]
        public List<Hero> Get(GetHeros request)
        {           
            List<Hero> heros = Db.Select<Data.Hero>().ConvertAll(u => u.TranslateTo<Hero>()).ToList();
            return heros;
        }

        //[Authenticate]
        public Hero Get(GetHero request)
        {
            var dataHero = Db.GetById<Data.Hero>(request.HeroId);
            
            if (dataHero == null)
            {
                throw new HttpError(HttpStatusCode.NotFound, "Hero does not exist");
            }

            Hero hero = dataHero.TranslateTo<Hero>();
            return hero;
        }

        //[Authenticate]
        public void Put(Hero hero)
        {
            using (IDbTransaction trans = Db.OpenTransaction())
            {
                Db.Update<Data.Hero>(hero.TranslateTo<Data.Hero>());            
                trans.Commit();
            }
        }

        //[Authenticate]
        public void Post(Hero hero)
        {
            using (IDbTransaction trans = Db.OpenTransaction())
            {
                var heroData = hero.TranslateTo<Data.Hero>();

                Db.Insert<Data.Hero>(heroData);
                long heroId = Db.GetLastInsertId();                
                trans.Commit();
            }
        }

        //[Authenticate]
        public void Delete(DeleteHero request)
        {
            using (IDbTransaction trans = Db.OpenTransaction())
            {
                Db.DeleteById<Data.Hero>(request.HeroId);
                trans.Commit();
            }
        }

        //[Authenticate]
        public Hero Get(GetNewHero request)
        {
            Hero hero = new Hero { Id = 0};     
            return hero;
        }
    }
}