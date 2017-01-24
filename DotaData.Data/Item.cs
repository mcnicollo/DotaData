using System;
using System.ComponentModel.DataAnnotations;
using ServiceStack.DataAnnotations;

namespace DotaData.Data
{
    [Alias("Items")]
    public class Item
    {
        [AutoIncrement]
        [PrimaryKey]
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
