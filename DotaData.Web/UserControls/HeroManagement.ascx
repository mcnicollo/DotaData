<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HeroManagement.ascx.cs" Inherits="DotaData.Web.UserControls.HeroManagement" %>
<script type="text/javascript">

    function HeroConfigViewModel()
    {
        var self = this;

        self.heros = ko.observableArray(null);
        self.items = ko.observableArray(null);
        self.currentHero = ko.observable(null);
        self.firstNameValidation = ko.observable(null);
        self.lastNameValidation = ko.observable(null);
        self.emailValidation = ko.observable(null);
        self.deleteHeroId = ko.observable(null);

        self.displayDeleteModal = ko.observable(false);
        self.displayViewModal = ko.observable(false);
        self.displayInventoryModal = ko.observable(false);        
        self.displayEditModal = ko.observable(false);
        self.displayAddModal = ko.observable(false);

        self.loadHeros = function ()
        {
            $.ajax(
            {
                url: "~/api/heros",
                data: {},
                contentType: "text/json;",
                success: function (data)
                {
                    self.heros(data);
                },
                error: function (error)
                {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.loadItems = function () {
            $.ajax(
            {
                url: "~/api/items",
                data: {},
                contentType: "text/json;",
                success: function (data) {
                    self.items(data);
                },
                error: function (error) {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.viewHero = function (hero)
        {
            self.loadHero(hero.Id);
            self.displayViewModal(true);
        }

        self.editHero = function (hero)
        {
            self.loadHero(hero.Id);
            self.displayEditModal(true);
        }

        self.createInventory = function (hero) {
            self.loadHero(hero.Id);
            self.displayInventoryModal(true);
        }

        self.addHero = function ()
        {
            $.ajax(
            {
                url: "~/api/heros/new",
                type: "GET",
                contentType: "text/json;",
                success: function (data)
                {
                    self.currentHero(ko.mapping.fromJS(data));
                    self.displayAddModal(true);
                },
                error: function (error)
                {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.showDeletePrompt = function(hero)
        {
            self.displayDeleteModal(true);
            self.deleteHeroId(hero.Id);
        }

        self.loadHero = function (heroId)
        {
            self.clearValidations();

            $.ajax(
            {
                url: "~/api/heros/" + heroId,
                contentType: "text/json;",
                success: function (data)
                {
                    self.currentHero(ko.mapping.fromJS(data));
                },
                error: function (error)
                {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.save = function ()
        {
            var verb = (self.currentHero().Id() == 0) ? "POST" : "PUT";
            self.clearValidations();

            $.ajax(
            {
                url: "~/api/heros",
                contentType: "application/json;",
                type: verb,
                data: ko.utils.stringifyJson(ko.mapping.toJS(self.currentHero)),
                success: function (data)
                {
                    self.displayEditModal(false);
                    self.displayAddModal(false);
                    self.loadHeros();
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

        self.saveInventory = function () {
            var verb = (self.currentHero().Id() == 0) ? "POST" : "PUT";
            self.clearValidations();

            $.ajax(
            {
                url: "~/api/heros",
                contentType: "application/json;",
                type: verb,
                data: ko.utils.stringifyJson(ko.mapping.toJS(self.currentHero)),
                success: function (data) {
                    self.displayEditModal(false);
                    self.displayAddModal(false);
                    self.loadHeros();
                },
                error: function (error) {
                    var validationErrors = getValidationErrors(error);
                    if (validationErrors != null) {
                        self.firstNameValidation(ko.utils.arrayFirst(validationErrors, function (error) { return error.FieldName == "FirstName"; }));
                        self.lastNameValidation(ko.utils.arrayFirst(validationErrors, function (error) { return error.FieldName == "LastName"; }));
                        self.emailValidation(ko.utils.arrayFirst(validationErrors, function (error) { return error.FieldName == "Email"; }));
                    }
                    else {
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

        self.deleteHero = function ()
        {
            $.ajax(
            {
                url: "~/api/heros/" + self.deleteHeroId(),
                type: "DELETE",
                contentType: "application/json;",
                success: function (data)
                {
                    self.loadHeros();
                },
                error: function (error)
                {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.loadHeros();
        self.loadItems();
    }

    $(document).ready(function ()
    {
        ko.applyBindings(new HeroConfigViewModel());
    })
</script>


<div style="height: 50px"></div>
<div style="margin: 10px">
    <button type="button" class="pull-right btn btn-lg btn-success" data-bind="click: addHero">New Hero</button>
    <h2>Heroes</h2>

    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th class="text-center">View</th>
                        <th>Name</th>
                        <th>HitPoints</th>
                        <th>Strength</th>
                        <th>Agility</th>
                        <th>Intelligence</th>
                        <th>Abilities</th>
                        <th class="text-center">Edit</th>
                        <th class="text-center">Inventory</th>
                        <th class="text-center">Delete</th>
                    </tr>
                </thead>
                <tbody data-bind="foreach: heros">
                    <tr>
                        <td class="text-center">
                            <button type="button" class="btn btn-primary" data-bind="click: $parent.viewHero">View</button>
                        </td>
                        <td><span data-bind="text: Name"></span></td>
                        <td><span data-bind="text: TotalHealth"></span></td>
                        <td><span data-bind="text: STR"></span></td>
                        <td><span data-bind="text: AGI"></span></td>
                        <td><span data-bind="text: INT"></span></td>
                        <td><span data-bind="text: Abilities"></span></td>
                        <td class="text-center">
                            <button type="button" class="btn btn-primary" data-bind="click: $parent.editHero">Edit</button>
                        </td>
                        <td class="text-center">
                            <button type="button" class="btn btn-primary" data-bind="click: $parent.createInventory">Inventory</button>
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
                <h4 class="modal-title" id="myModalViewLabel">View Hero</h4>
            </div>
            <div class="modal-body" data-bind="with: currentHero">
                <!--<div data-bind="if: Name==Io" class="col-md-6">
                    <IMG SRC="\Images\Io.png">
                </div>-->
                <form>
                    <!--
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="exampleInputView1">Name</label>
                            <input type="text" class="form-control" id="exampleInputView1" data-bind="value: Name" disabled="disabled">
                        </div>  
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label for="exampleInputView2">Str</label>
                            <input type="text" class="form-control" id="exampleInputView2" data-bind="value: STR" disabled="disabled">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label for="exampleInputView3">Agi</label>
                            <input type="text" class="form-control" id="exampleInputView3" data-bind="value: AGI" disabled="disabled">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label for="exampleInputView4">Int</label>
                            <input type="text" class="form-control" id="exampleInputView4" data-bind="value: INT " disabled="disabled">
                        </div>
                    </div>
                    -->

                    <div class="form-group">
                        <label for="exampleInputView1">Name</label>
                        <input type="text" class="form-control" id="exampleInputView1" data-bind="value: Name" disabled="disabled">
                    </div>  

                    <div class="form-group">
                        <label for="exampleInputView2">Hitpoints</label>
                        <input type="text" class="form-control" id="exampleInputView2" data-bind="value: TotalHealth" disabled="disabled">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputView2">Str</label>
                        <input type="text" class="form-control" id="exampleInputView2" data-bind="value: STR" disabled="disabled">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputView3">Agi</label>
                        <input type="text" class="form-control" id="exampleInputView3" data-bind="value: AGI" disabled="disabled">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputView4">Int</label>
                        <input type="text" class="form-control" id="exampleInputView4" data-bind="value: INT " disabled="disabled">
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
                <h4 class="modal-title" id="myModalLabel">New Hero</h4>
            </div>
            <div class="modal-body" data-bind="with: currentHero">
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
                <h4 class="modal-title" id="myModalEditLabel">Edit Hero</h4>
            </div>
            <div class="modal-body" data-bind="with: currentHero">
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
                        <input type="email" class="form-control" id="exampleInputEdit3" data-bind="value: AGI">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEdit4">Intelligence</label>
                        <input type="email" class="form-control" id="exampleInputEdit4" data-bind="value: INT">
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
<div class="modal fade" data-bind="bootstrapModal: displayInventoryModal" tabindex="-1" role="dialog" style="display: none;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalInventoryLabel">Edit Inventory</h4>
            </div>
            <div class="modal-body" data-bind="with: currentHero">
                <form>
                    <div class="form-group">
                        <label for="exampleInputInventory1">Slot One</label>
                        <select class="form-control" id="exampleInputInventory1" data-bind="options: $parent.items, optionsText: 'Name',optionsCaption: 'Select an item...', optionsValue: 'Slot1'"></select>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputInventory2">Slot Two</label>
                        <select class="form-control" id="exampleInputInventory2" data-bind="options: $parent.items, optionsText: 'Name', optionsCaption: 'Select an item...', optionsValue: 'Slot2'"></select>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputInventory3">Slot Three</label>
                        <select class="form-control" id="exampleInputInventory3" data-bind="options: $parent.items, optionsText: 'Name', optionsCaption: 'Select an item...', optionsValue: 'Slot3'"></select>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputInventory4">Slot Four</label>
                        <select class="form-control" id="exampleInputInventory4" data-bind="options: $parent.items, optionsText: 'Name', optionsCaption: 'Select an item...', optionsValue: 'Slot4'"></select>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputInventory5">Slot Five</label>
                        <select class="form-control" id="exampleInputInventory5" data-bind="options: $parent.items, optionsText: 'Name', optionsCaption: 'Select an item...', optionsValue: 'Slot5'"></select>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputInventory6">Slot Six</label>
                        <select class="form-control" id="exampleInputInventory6" data-bind="options: $parent.items, optionsText: 'Name', optionsCaption: 'Select an item...', optionsValue: 'Slot6'"></select>
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
                <h4 class="modal-title" id="myModalDeleteLabel">Delete Hero</h4>
            </div>
            <div class="modal-body">
                <div class="alert alert-danger" role="alert">
                    Are you sure you want to delete this hero?
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal" data-bind="click: $root.deleteHero">Delete</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>
