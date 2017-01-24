<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ItemManagement.ascx.cs" Inherits="DotaData.Web.UserControls.ItemManagement" %>
<script type="text/javascript">

    function ItemConfigViewModel()
    {
        var self = this;

        self.items = ko.observableArray(null);
        self.currentItem = ko.observable(null);
        self.firstNameValidation = ko.observable(null);
        self.lastNameValidation = ko.observable(null);
        self.emailValidation = ko.observable(null);
        self.deleteItemId = ko.observable(null);

        self.displayDeleteModal = ko.observable(false);
        self.displayViewModal = ko.observable(false);
        self.displayEditModal = ko.observable(false);
        self.displayAddModal = ko.observable(false);

        self.loadItems = function ()
        {
            $.ajax(
            {
                url: "~/api/items",
                data: {},
                contentType: "text/json;",
                success: function (data)
                {
                    self.items(data);
                },
                error: function (error)
                {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.viewItem = function (item)
        {
            self.loadItem(item.Id);
            self.displayViewModal(true);
        }

        self.editItem = function (item)
        {
            self.loadItem(item.Id);
            self.displayEditModal(true);
        }

        self.addItem = function ()
        {
            $.ajax(
            {
                url: "~/api/items/new",
                type: "GET",
                contentType: "text/json;",
                success: function (data)
                {
                    self.currentItem(ko.mapping.fromJS(data));
                    self.displayAddModal(true);
                },
                error: function (error)
                {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.showDeletePrompt = function(item)
        {
            self.displayDeleteModal(true);
            self.deleteItemId(item.Id);
        }

        self.loadItem = function (itemId)
        {
            self.clearValidations();

            $.ajax(
            {
                url: "~/api/items/" + itemId,
                contentType: "text/json;",
                success: function (data)
                {
                    self.currentItem(ko.mapping.fromJS(data));
                },
                error: function (error)
                {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.save = function ()
        {
            var verb = (self.currentItem().Id() == 0) ? "POST" : "PUT";
            self.clearValidations();

            $.ajax(
            {
                url: "~/api/items",
                contentType: "application/json;",
                type: verb,
                data: ko.utils.stringifyJson(ko.mapping.toJS(self.currentItem)),
                success: function (data)
                {
                    self.displayEditModal(false);
                    self.displayAddModal(false);
                    self.loadItems();
                },
                error: function (error)
                {
                    var validationErrors = getValidationErrors(error);
                    if (validationErrors != null)
                    {
                        self.firstNameValidation(ko.utils.arrayFirst(validationErrors, function (error) { return error.FieldName == "FirstName"; }));
                        self.lastNameValidation(ko.utils.arrayFirst(validationErrors, function (error) { return error.FieldName == "LastName"; }));
                        self.emailValidation(ko.utils.arrayFirst(validationErrors, function (error) { return error.FieldName == "Email"; }));
                    }
                    else
                    {
                        alert(error.status + " - " + error.statusText);
                    }
                }
            });
        }

        self.clearValidations = function ()
        {
            self.firstNameValidation(null);
            self.lastNameValidation(null);
            self.emailValidation(null);
        }

        self.deleteItem = function ()
        {
            $.ajax(
            {
                url: "~/api/items/" + self.deleteItemId(),
                type: "DELETE",
                contentType: "application/json;",
                success: function (data)
                {
                    self.loadItems();
                },
                error: function (error)
                {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.loadItems();
    }

    $(document).ready(function ()
    {
        ko.applyBindings(new ItemConfigViewModel());
    })
</script>


<div style="height: 50px"></div>
<div style="margin: 10px">
    <button type="button" class="pull-right btn btn-lg btn-success" data-bind="click: addItem">New Item</button>
    <h2>Items</h2>

    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th class="text-center">View</th>
                        <th>Id</th>
                        <th>Name</th>
                        <th>Strength</th>
                        <th>Agility</th>
                        <th>Intelligence</th>
                        <th>Damage</th>
                        <th>Active</th>
                        <th class="text-center">Edit</th>
                        <th class="text-center">Delete</th>
                    </tr>
                </thead>
                <tbody data-bind="foreach: items">
                    <tr>
                        <td class="text-center">
                            <button type="button" class="btn btn-primary" data-bind="click: $parent.viewItem">View</button>
                        </td>
                        <td><span data-bind="text: Id"></span></td>
                        <td><span data-bind="text: Name"></span></td>
                        <td><span data-bind="text: STR"></span></td>
                        <td><span data-bind="text: AGI"></span></td>
                        <td><span data-bind="text: INT"></span></td>
                        <td><span data-bind="text: AttackDamage"></span></td>
                        <td><span data-bind="text: Active"></span></td>
                        <td class="text-center">
                            <button type="button" class="btn btn-primary" data-bind="click: $parent.editItem">Edit</button>
                        </td>
                        <td class="text-center">
                            <button type="button" class="btn btn-danger" data-bind="click: $parent.showDeletePrompt">Delete</button>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" data-bind="bootstrapModal: displayViewModal"  tabindex="-1" role="dialog" style="display: none;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalViewLabel">View Item</h4>
            </div>
            <div class="modal-body" data-bind="with: currentItem">
                <form>
                    <div class="form-group">
                        <label for="exampleInputView1">Name</label>
                        <input type="text" class="form-control" id="exampleInputView1" data-bind="value: Name" disabled="disabled">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputView2">Strength</label>
                        <input type="text" class="form-control" id="exampleInputView2" data-bind="value: STR" disabled="disabled">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputView3">Agility</label>
                        <input type="text" class="form-control" id="exampleInputView3" data-bind="value: AGI" disabled="disabled">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputView4">Intelligence</label>
                        <input type="text" class="form-control" id="exampleInputView4" data-bind="value: INT" disabled="disabled">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputView5">Damage</label>
                        <input type="text" class="form-control" id="exampleInputView5" data-bind="value: AttackDamage" disabled="disabled">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputView6">Active Ability</label>
                        <input type="text" class="form-control" id="exampleInputView6" data-bind="value: Active" disabled="disabled">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" data-bind="bootstrapModal: displayAddModal" tabindex="-1" role="dialog" style="display: none;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">New Item</h4>
            </div>
            <div class="modal-body" data-bind="with: currentItem">
                <form>
                    <div class="form-group">
                        <label for="exampleInputNew1">Name</label>
                        <input type="text" class="form-control" id="exampleInputNew1" data-bind="value: Name" >
                    </div>
                    <div class="form-group">
                        <label for="exampleInputNew2">Strength</label>
                        <input type="text" class="form-control" id="exampleInputNew2" data-bind="value: STR">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputNew3">Agility</label>
                        <input type="text" class="form-control" id="exampleInputNew3" data-bind="value: AGI">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputNew4">Intelligence</label>
                        <input type="text" class="form-control" id="exampleInputNew4" data-bind="value: INT">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputNew5">Damage</label>
                        <input type="text" class="form-control" id="exampleInputNew5" data-bind="value: AttackDamage">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputNew6">Active Ability</label>
                        <input type="text" class="form-control" id="exampleInputNew6" data-bind="value: Active">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-success" data-bind="click: save">Save changes</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" data-bind="bootstrapModal: displayEditModal" tabindex="-1" role="dialog" style="display: none;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalEditLabel">Edit Item</h4>
            </div>
            <div class="modal-body" data-bind="with: currentItem">
                <form>
                    <div class="form-group">
                        <label for="exampleInputNew1">Name</label>
                        <input type="text" class="form-control" id="exampleInputEdit1" data-bind="value: Name">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputNew2">Strength</label>
                        <input type="text" class="form-control" id="exampleInputEdit2" data-bind="value: STR">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputNew3">Agility</label>
                        <input type="text" class="form-control" id="exampleInputEdit3" data-bind="value: AGI">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEdit4">Intelligence</label>
                        <input type="text" class="form-control" id="exampleInputEdit4" data-bind="value: INT">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEdit5">Damage</label>
                        <input type="text" class="form-control" id="exampleInputEdit5" data-bind="value: AttackDamage">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEdit6">Active Ability</label>
                        <input type="text" class="form-control" id="exampleInputEdit6" data-bind="value: Active">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-success"  data-bind="click: save" >Save changes</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade"  tabindex="-1" role="dialog" data-bind="bootstrapModal: displayDeleteModal" style="display: none;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalDeleteLabel">Delete Item</h4>
            </div>
            <div class="modal-body">
                <div class="alert alert-danger" role="alert">
                    Are you sure you want to delete this item?
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal" data-bind="click: $root.deleteItem">Delete</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>
