<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserManagement.ascx.cs" Inherits="DotaData.Web.UserControls.UserManagement" %>
<script type="text/javascript">

    function UserConfigViewModel()
    {
        var self = this;

        self.users = ko.observableArray(null);
        self.currentUser = ko.observable(null);
        self.firstNameValidation = ko.observable(null);
        self.lastNameValidation = ko.observable(null);
        self.emailValidation = ko.observable(null);
        self.deleteUserId = ko.observable(null);

        self.displayDeleteModal = ko.observable(false);
        self.displayViewModal = ko.observable(false);
        self.displayEditModal = ko.observable(false);
        self.displayAddModal = ko.observable(false);

        self.loadUsers = function ()
        {
            $.ajax(
            {
                url: "~/api/users",
                data: {},
                contentType: "text/json;",
                success: function (data)
                {
                    self.users(data);
                },
                error: function (error)
                {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.viewUser = function (user)
        {
            self.loadUser(user.Id);
            self.displayViewModal(true);
        }

        self.editUser = function (user)
        {
            self.loadUser(user.Id);
            self.displayEditModal(true);
        }

        self.addUser = function ()
        {
            $.ajax(
            {
                url: "~/api/users/new",
                type: "GET",
                contentType: "text/json;",
                success: function (data)
                {
                    //self.currentUser(ko.mapping.fromJS(data));
                    self.displayAddModal(true);
                },
                error: function (error)
                {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.showDeletePrompt = function(user)
        {
            self.displayDeleteModal(true);
            self.deleteUserId(user.Id);
        }

        self.loadUser = function (userId)
        {
            self.clearValidations();

            $.ajax(
            {
                url: "~/api/users/" + userId,
                contentType: "text/json;",
                success: function (data)
                {
                    self.currentUser(ko.mapping.fromJS(data));
                },
                error: function (error)
                {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.save = function ()
        {
            var verb = (self.currentUser().Id() == 0) ? "POST" : "PUT";
            self.clearValidations();

            $.ajax(
            {
                url: "~/api/users",
                contentType: "application/json;",
                type: verb,
                data: ko.utils.stringifyJson(ko.mapping.toJS(self.currentUser)),
                success: function (data)
                {
                    self.displayEditModal(false);
                    self.displayAddModal(false);
                    self.loadUsers();
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

        self.deleteUser = function ()
        {
            $.ajax(
            {
                url: "~/api/users/" + self.deleteUserId(),
                type: "DELETE",
                contentType: "application/json;",
                success: function (data)
                {
                    self.loadUsers();
                },
                error: function (error)
                {
                    alert(error.status + " - " + error.statusText);
                }
            });
        }

        self.loadUsers();
    }

    $(document).ready(function ()
    {
        ko.applyBindings(new UserConfigViewModel());
    })
</script>


<div style="height: 50px"></div>
<div style="margin: 10px">
    <button type="button" class="pull-right btn btn-lg btn-success" data-bind="click: addUser">New User</button>
    <h2>Users</h2>

    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th class="text-center">View</th>
                        <th>Id</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Permissions</th>
                        <th class="text-center">Edit</th>
                        <th class="text-center">Delete</th>
                    </tr>
                </thead>
                <tbody data-bind="foreach: users">
                    <tr>
                        <td class="text-center">
                            <button type="button" class="pull-right btn btn-primary" data-bind="click: $parent.viewUser">View</button>
                        </td>
                        <td><span data-bind="text: Id"></span></td>
                        <td><span data-bind="text: FirstName"></span></td>
                        <td><span data-bind="text: LastName"></span></td>
                        <td><span data-bind="text: Email"></span></td>
                        <td><span data-bind="text: Phone"></span></td>
                        <td><span data-bind="text: PermissionList"></span></td>
                        <td class="text-center">
                            <button type="button" class="pull-right btn btn-primary" data-bind="click: $parent.editUser">Edit</button>
                        </td>
                        <td class="text-center">
                            <button type="button" class="pull-right btn btn-danger" data-bind="click: $parent.showDeletePrompt">Delete</button>
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
                <h4 class="modal-title" id="myModalViewLabel">View User</h4>
            </div>
            <div class="modal-body" data-bind="with: currentUser">
                <form>
                    <div class="form-group">
                        <label for="exampleInputView1">First Name</label>
                        <input type="text" class="form-control" id="exampleInputView1" data-bind="value: FirstName" disabled="disabled">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputView2">Last Name</label>
                        <input type="text" class="form-control" id="exampleInputView2" data-bind="value: LastName" disabled="disabled">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputView3">Email</label>
                        <input type="email" class="form-control" id="exampleInputView3" data-bind="value: Email" disabled="disabled">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputView4">Phone</label>
                        <input type="text" class="form-control" id="exampleInputView4" data-bind="value: Phone" disabled="disabled">
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <table >
                                <thead>
                                    <tr>
                                        <th>Permissions</th>
                                    </tr>
                                </thead>
                                <tbody data-bind="foreach: Permissions">
                                    <!-- ko if: IsSelected -->
                                    <tr>
                                        <td data-bind="text: Name"></td>
                                    </tr>
                                    <!-- /ko -->
                                </tbody>
                            </table>
                        </div>
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
                <h4 class="modal-title" id="myModalLabel">New User</h4>
            </div>
            <div class="modal-body" data-bind="with: currentUser">
                <form>
                    <div class="form-group" data-bind="css: { 'has-error': $parent.firstNameValidation }">
                        <label for="exampleInputNew1">First Name</label>
                        <input type="text" class="form-control" id="exampleInputNew1" data-bind="value: FirstName" >
                        <!-- ko with: $parent.firstNameValidation -->
                        <span class="help-block" data-bind="text: Message"></span>
                        <!-- /ko -->
                    </div>
                    <div class="form-group"  data-bind="css: { 'has-error': $parent.lastNameValidation }">
                        <label for="exampleInputNew2">Last Name</label>
                        <input type="text" class="form-control" id="exampleInputNew2" data-bind="value: LastName">
                        <!-- ko with: $parent.lastNameValidation -->
                        <span class="help-block" data-bind="text: Message"></span>
                        <!-- /ko -->
                    </div>
                    <div class="form-group" data-bind="css: { 'has-error': $parent.emailValidation }">
                        <label for="exampleInputNew3">Email</label>
                            <input type="email" class="form-control" id="exampleInputNew3" data-bind="value: Email">
                            <!-- ko with: $parent.emailValidation -->
                            <span class="help-block" data-bind="text: Message"></span>
                            <!-- /ko -->
                    </div>
                    <div class="form-group">
                        <label for="exampleInputNew4">Phone</label>
                        <input type="text" class="form-control" id="exampleInputNew4" data-bind="value: Phone">
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <table >
                                <thead>
                                    <tr>
                                        <th colspan="2">Permissions</th>
                                    </tr>
                                </thead>
                                <tbody data-bind="foreach: Permissions">
                                    <tr>
                                        <td>
                                            <input type="checkbox" data-bind="checked: IsSelected" />

                                        </td>
                                        <td>
                                            <span data-bind="text: Name"></span>

                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
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
                <h4 class="modal-title" id="myModalEditLabel">Edit User</h4>
            </div>
            <div class="modal-body" data-bind="with: currentUser">
                <form>
                    <div class="form-group"  data-bind="css: { 'has-error': $parent.firstNameValidation }">
                        <label for="exampleInputNew1">First Name</label>
                        <input type="text" class="form-control" id="exampleInputEdit1" data-bind="value: FirstName">
                        <!-- ko with: $parent.firstNameValidation -->
                        <span class="help-block" data-bind="text: Message"></span>
                        <!-- /ko -->
                    </div>
                    <div class="form-group" data-bind="css: { 'has-error': $parent.lastNameValidation }">
                        <label for="exampleInputNew2">Last Name</label>
                        <input type="text" class="form-control" id="exampleInputEdit2" data-bind="value: LastName">
                        <!-- ko with: $parent.lastNameValidation -->
                        <span class="help-block" data-bind="text: Message"></span>
                        <!-- /ko -->
                    </div>
                    <div class="form-group"  data-bind="css: { 'has-error': $parent.emailValidation }">
                        <label for="exampleInputNew3">Email</label>
                        <input type="email" class="form-control" id="exampleInputEdit3" data-bind="value: Email">
                        <!-- ko with: $parent.emailValidation -->
                        <span class="help-block" data-bind="text: Message"></span>
                        <!-- /ko -->
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEdit4">Phone</label>
                        <input type="email" class="form-control" id="exampleInputEdit4" data-bind="value: Phone">
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <table >
                                <thead>
                                    <tr>
                                        <th colspan="2" >Permissions</th>
                                    </tr>
                                </thead>
                                <tbody data-bind="foreach: Permissions">
                                    <tr>

                                        <td>
                                            <input type="checkbox" data-bind="checked: IsSelected" />

                                        </td>
                                        <td>
                                            <span data-bind="text: Name"></span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
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
                <h4 class="modal-title" id="myModalDeleteLabel">Delete User</h4>
            </div>
            <div class="modal-body">
                <div class="alert alert-danger" role="alert">
                    Are you sure you want to delete this user?
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal" data-bind="click: $root.deleteUser">Delete</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>
