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
    public class ItemService : ServiceBase
    {
       // [Authenticate]
        public List<Item> Get(GetItems request)
        {           
            List<Item> items = Db.Select<Data.Item>().ConvertAll(u => u.TranslateTo<Item>()).ToList();
            return items;
        }

        //[Authenticate]
        public Item Get(GetItem request)
        {
            var dataItem = Db.GetById<Data.Item>(request.ItemId);
            
            if (dataItem == null)
            {
                throw new HttpError(HttpStatusCode.NotFound, "Item does not exist");
            }

            Item item = dataItem.TranslateTo<Item>();
            return item;
        }

        //[Authenticate]
        public void Put(Item item)
        {
            using (IDbTransaction trans = Db.OpenTransaction())
            {
                Db.Update<Data.Item>(item.TranslateTo<Data.Item>());            
                trans.Commit();
            }
        }

        //[Authenticate]
        public void Post(Item item)
        {
            using (IDbTransaction trans = Db.OpenTransaction())
            {
                var itemData = item.TranslateTo<Data.Item>();

                Db.Insert<Data.Item>(itemData);
                long itemId = Db.GetLastInsertId();                
                trans.Commit();
            }
        }

        //[Authenticate]
        public void Delete(DeleteItem request)
        {
            using (IDbTransaction trans = Db.OpenTransaction())
            {
                Db.DeleteById<Data.Item>(request.ItemId);
                trans.Commit();
            }
        }

        //[Authenticate]
        public Item Get(GetNewItem request)
        {
            Item item = new Item { Id = 0};     
            return item;
        }
    }
}