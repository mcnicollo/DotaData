using System;
using System.ComponentModel.DataAnnotations;
using ServiceStack.DataAnnotations;

namespace DotaData.Data
{
    [Alias("Heros")]
    public class Hero
    {
        [AutoIncrement]
        [PrimaryKey]
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
    }
}
