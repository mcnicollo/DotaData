using DotaData.ServiceModel.Types;
using ServiceStack.ServiceHost;
using System.Collections.Generic;

namespace DotaData.ServiceModel
{
    [Route("/items", "GET")]
    public class GetItems : IReturn<List<Item>>
    {
    }

    [Route("/items/{ItemId}", "GET")]
    public class GetItem : IReturn<Item>
    {
        public int ItemId { get; set; }
    }

    [Route("/items/{ItemId}", "DELETE")]
    public class DeleteItem
    {
        public int ItemId { get; set; }
    }

    [Route("/items/new", "GET")]
    public class GetNewItem
    {
    }
}
