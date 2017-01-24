using ServiceStack.ServiceHost;
using System;
using System.Collections.Generic;

namespace DotaData.ServiceModel
{
    [Route("/inventories", "PUT")]
    [Route("/inventories", "POST")]
    public class Inventory
    {
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
