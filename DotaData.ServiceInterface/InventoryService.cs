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
    public class InventoryService : ServiceBase
    {
       // [Authenticate]
        public List<Inventory> Get(GetInventories request)
        {
            List<Inventory> inventories = Db.Select<Data.Inventory>().ConvertAll(u => u.TranslateTo<Inventory>()).ToList();
            return inventories;
        }

        //[Authenticate]
        public Inventory Get(GetInventory request)
        {
            var dataInventory = Db.GetById<Data.Inventory>(request.InventoryId);
            
            if (dataInventory == null)
            {
                throw new HttpError(HttpStatusCode.NotFound, "Inventory does not exist");
            }

            Inventory iventory = dataInventory.TranslateTo<Inventory>();
            return iventory;
        }

        //[Authenticate]
        public void Put(Inventory iventory)
        {
            using (IDbTransaction trans = Db.OpenTransaction())
            {
                Db.Update<Data.Inventory>(iventory.TranslateTo<Data.Inventory>());            
                trans.Commit();
            }
        }

        //[Authenticate]
        public void Post(Inventory iventory)
        {
            using (IDbTransaction trans = Db.OpenTransaction())
            {
                var iventoryData = iventory.TranslateTo<Data.Inventory>();

                Db.Insert<Data.Inventory>(iventoryData);
                long iventoryId = Db.GetLastInsertId();                
                trans.Commit();
            }
        }

        //[Authenticate]
        public void Delete(DeleteInventory request)
        {
            using (IDbTransaction trans = Db.OpenTransaction())
            {
                Db.DeleteById<Data.Inventory>(request.InventoryId);
                trans.Commit();
            }
        }

        //[Authenticate]
        public Inventory Get(GetNewInventory request)
        {
            Inventory iventory = new Inventory { Id = 0};     
            return null;
        }
    }
}