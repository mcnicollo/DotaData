using System;
using System.ComponentModel.DataAnnotations;
using ServiceStack.DataAnnotations;

namespace DotaData.Data
{
    [Alias("Inventories")]
    public class Inventory
    {
        [AutoIncrement]
        [PrimaryKey]
        public int Id { get; set; }
        public int heroId { get; set; }
        public int Slot1 { get; set; }
        public int Slot2 { get; set; }
        public int Slot3 { get; set; }
        public int Slot4 { get; set; }
        public int Slot5 { get; set; }
        public int Slot6 { get; set; }

    }
}
