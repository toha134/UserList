<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>AngularJS $http Example</title>
<style>
.username.ng-valid {
	background-color: lightgreen;
}

.username.ng-dirty.ng-invalid-required {
	background-color: red;
}

.username.ng-dirty.ng-invalid-minlength {
	background-color: yellow;
}
</style>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<link href="http://netdna.bootstrapcdn.com/font-awesome/2.0/css/font-awesome.css" rel="stylesheet">
</head>
<body ng-app="myApp" class="ng-cloak">
	<div class="generic-container" ng-controller="UserController as ctrl">
		<div class="panel panel-default">
			<div class="panel-heading">
				<span class="lead">User Registration Form </span>
			</div>
			<div class="formcontainer">
				<form ng-submit="ctrl.submit()" name="myForm"
					class="form-horizontal">
					<input type="hidden" ng-model="ctrl.user.id" />
					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="file">Name</label>
							<div class="col-md-7">
								<input type="text" ng-model="ctrl.user.name" name="name"
									class="name form-control input-sm" placeholder="Enter name"
									required ng-minlength="3" />
								<div class="has-error" ng-show="myForm.$dirty">
									<span ng-show="myForm.uname.$error.required">This is a required field</span> 
									<span ng-show="myForm.uname.$error.minlength">Minimum length required is 3</span> 
									<span ng-show="myForm.uname.$invalid">This field is invalid </span>
								</div>
							</div>
						</div>
					</div>


					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="file">Age</label>
							<div class="col-md-7">
								<input type="number" ng-model="ctrl.user.age"
									class="form-control input-sm" min="1" name="age"
									placeholder="Enter user Age. [Age greater 0]" />
								<div class="has-error" ng-show="myForm.$dirty">
									<span ng-show="myForm.age.$error.min">Age must be greater 0</span> <span
										ng-show="myForm.age.$invalid">This field is
										invalid </span>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="file">Created
								Date</label>
							<div class="col-md-7">
								<input type="date" value="{{ ctrl.user.createdDate | date: 'yyyy-MM-dd' }}" ng-model="ctrl.user.createdDate"
									name="createdDate" class="date form-control input-sm"
									placeholder="Enter created date" required />
								<div class="has-error" ng-show="myForm.$dirty">
									<span ng-show="myForm.createdDate.$error.required">This
										is a required field</span> <span
										ng-show="myForm.createdDate.$invalid">This field is
										invalid </span>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="file">Admin</label>
							<div class="col-md-7">
								<input type="checkbox" ng-model="ctrl.user.admin" name="admin"
									class="admin form-control input-sm" />
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-actions floatRight">
							<input type="submit" value="{{!ctrl.user.id ? 'Add' : 'Update'}}"
								class="btn btn-primary btn-sm" ng-disabled="myForm.$invalid">
							<button type="button" ng-click="ctrl.reset()"
								class="btn btn-warning btn-sm" ng-disabled="myForm.$pristine">Reset
								Form</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">
				<span class="lead">List of Users </span>
			</div>
			<div class="input-group">
                <input type="text" class="form-control" ng-model="query" ng-change="ctrl.search()" placeholder="Search">
            	<div class="input-group-btn">
                  <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
               </div>
            </div>
			<div class="tablecontainer">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>ID.</th>
							<th>Name</th>
							<th>Age</th>
							<th>Admin</th>
							<th>Created Date</th>
							<th width="20%"></th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="u in ctrl.pagedItems[ctrl.currentPage]">
							<td><span ng-bind="u.id"></span></td>
							<td><span ng-bind="u.name"></span></td>
							<td><span ng-bind="u.age"></span></td>
							<td><span ng-bind="u.admin"></span></td>
							<td><span ng-bind="u.createdDate | date:'dd/MM/yyyy'"></span></td>
							<td>
								<button type="button" ng-click="ctrl.edit(u.id)"
									class="btn btn-success custom-width">Edit</button>
								<button type="button" ng-click="ctrl.remove(u.id)"
									class="btn btn-danger custom-width">Remove</button>
							</td>
						</tr>
					</tbody>
					<tfoot>
                    <td colspan="6">
                        <div class="pull-right">
                            <ul class="pagination">
                                <li ng-class="{disabled: ctrl.currentPage == 0}">
                                    <a href ng-click="ctrl.prevPage()">« Prev</a>
                                </li>
                                <li ng-repeat="n in ctrl.range(ctrl.pagedItems.length)"
                                    ng-class="{active: n == ctrl.currentPage}"
                                	ng-click="ctrl.setPage(n)">
                                    <a href ng-bind="n + 1">1</a>
                                </li>
                                <li ng-class="{disabled: ctrl.currentPage == ctrl.pagedItems.length - 1}">
                                    <a href ng-click="ctrl.nextPage()">Next »</a>
                                </li>
                            </ul>
                        </div>
                    </td>
                </tfoot>
				</table>
			</div>

		</div>
		<div class="row">
			<button type="button" ng-click="ctrl.add()"
				class="btn btn-success custom-width">Add new</button>
		</div>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>
	<script src="<c:url value='/static/js/app.js' />"></script>
	<script src="<c:url value='/static/js/service/user_service.js' />"></script>
	<script
		src="<c:url value='/static/js/controller/user_controller.js' />"></script>
</body>
</html>