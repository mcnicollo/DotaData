using DotaData.ServiceModel.Types;
using ServiceStack.ServiceHost;
using System.Collections.Generic;

namespace DotaData.ServiceModel
{
    [Route("/heros", "GET")]
    public class GetHeros : IReturn<List<Hero>>
    {
    }

    [Route("/heros/{HeroId}", "GET")]
    public class GetHero : IReturn<Hero>
    {
        public int HeroId { get; set; }
    }

    [Route("/heros/{HeroId}", "DELETE")]
    public class DeleteHero
    {
        public int HeroId { get; set; }
    }

    [Route("/heros/new", "GET")]
    public class GetNewHero
    {
    }
}
