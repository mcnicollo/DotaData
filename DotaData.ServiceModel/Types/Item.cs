using ServiceStack.ServiceHost;
using System;
using System.Collections.Generic;

namespace DotaData.ServiceModel
{
    [Route("/items", "PUT")]
    [Route("/items", "POST")]
    public class Item
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int STR { get; set; }
        public int AGI { get; set; }
        public int INT { get; set; }
        public int MoveSpeed { get; set; }
        public int Armor { get; set; }
        public int AttackDamage { get; set; }
        public int AttackSpeed { get; set; }
        public int HitPoints { get; set; }
        public int ManaPoints { get; set; }
        public string Active { get; set; }
        public string Passive { get; set; }
        public int goldCost { get; set; }

    }
}
