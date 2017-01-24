using ServiceStack.ServiceHost;
using System;
using System.Collections.Generic;

namespace DotaData.ServiceModel
{
    [Route("/heros", "PUT")]
    [Route("/heros", "POST")]
    public class Hero
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int HitPoints { get; set; }
        public int STR { get; set; }
        public int AGI { get; set; }
        public int INT { get; set; }
        public int MoveSpeed { get; set; }
        public int BaseArmor { get; set; }
        public int BaseDamage { get; set; }
        public int BaseAttackSpeed { get; set; }
        public int Abilities { get; set; }
        public int Gold { get; set; }
        public int TotalHealth
        {
            get
            {
                return HitPoints + (19 * STR);
            }
        }
    }
}
