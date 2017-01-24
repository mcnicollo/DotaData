using DotaData.ServiceModel.Types;
using ServiceStack.ServiceHost;
using System.Collections.Generic;

namespace DotaData.ServiceModel
{
    [Route("/inventories", "GET")]
    public class GetInventories : IReturn<List<Inventory>>
    {
    }

    [Route("/inventories/{InventoryId}", "GET")]
    public class GetInventory : IReturn<Inventory>
    {
        public int InventoryId { get; set; }
    }

    [Route("/inventories/{InventoryId}", "DELETE")]
    public class DeleteInventory
    {
        public int InventoryId { get; set; }
    }

    [Route("/inventories/new", "GET")]
    public class GetNewInventory
    {
    }
}
