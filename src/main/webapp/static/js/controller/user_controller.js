'use strict';

App.controller('UserController', ['$scope', '$filter', 'UserService', function($scope, $filter, UserService) {
          var self = this;
          self.itemsPerPage = 5;
          self.filteredItems = [];
          self.pagedItems = [];
          self.currentPage = 0;
          self.user={id:null,name:'',age:10,admin:'false',createdDate:new Date('2010-01-01')};
          self.users=[];
              
          self.fetchAllUsers = function(){
              UserService.fetchAllUsers()
                  .then(
      					       function(d) {
      						        self.users = d;
      						        self.search();
      					       },
            					function(errResponse){
            						console.error('Error while fetching Users');
            					}
      			       );
              
          };
           
          self.createUser = function(user){
              UserService.createUser(user)
		              .then(
                      self.fetchAllUsers, 
				              function(errResponse){
					               console.error('Error while creating User.');
				              }	
                  );
          };

         self.updateUser = function(user, id){
              UserService.updateUser(user, id)
		              .then(
				              self.fetchAllUsers, 
				              function(errResponse){
					               console.error('Error while updating User.');
				              }	
                  );
          };

         self.deleteUser = function(id){
              UserService.deleteUser(id)
		              .then(
				              self.fetchAllUsers, 
				              function(errResponse){
					               console.error('Error while deleting User.');
				              }	
                  );
          };

          self.submit = function() {
              if(self.user.id==null){
                  console.log('Saving New User', self.user);    
                  self.createUser(self.user);
              }else{
                  self.updateUser(self.user, self.user.id);
                  console.log('User updated with id ', self.user.id);
              }
              self.reset();
          };
              
          self.edit = function(id){
              console.log('id to be edited', id);
              for(var i = 0; i < self.users.length; i++){
                  if(self.users[i].id == id) {
                     self.user = angular.copy(self.users[i]);
                     self.user.createdDate = new Date(self.users[i].createdDate);
                     break;
                  }
              }
          };
              
          self.remove = function(id){
              console.log('id to be deleted', id);
              for(var i = 0; i < self.users.length; i++){
                  if(self.users[i].id == id) {
                     self.reset();
                     break;
                  }
              }
              self.deleteUser(id);
          };

          
          self.reset = function(){
              self.user={id:null,name:'',age:10,admin:'false',createdDate:new Date('2010-01-01')};
              $scope.myForm.$setPristine(); //reset Form
          };
          
          self.add = function(){
              self.user={id:null,name:'',age:10,admin:'false',createdDate:new Date('2010-01-01')};
              $scope.myForm.$setPristine(); //reset Form
          };
          
          var searchMatch = function (haystack, needle) {
              if (!needle) {
                  return true;
              }
              return haystack.toLowerCase().indexOf(needle.toLowerCase()) !== -1;
          };

          // init the filtered items
          self.search = function () {
        	  self.filteredItems = 
        	  $filter('filter')(self.users, function (item) {
                      if (searchMatch(item.name, $scope.query))
                          return true;
                      else
                  return false;
              });
              // take care of the sorting order
              self.currentPage = 0;
              // now group by pages
              self.groupToPages();
          };
          
          // calculate page in place
          self.groupToPages = function () {
        	  self.pagedItems = [];
              
              for (var i = 0; i < self.filteredItems.length; i++) {
                  if (i % self.itemsPerPage === 0) {
                      self.pagedItems[Math.floor(i / self.itemsPerPage)] = [ self.filteredItems[i] ];
                  } else {
                      self.pagedItems[Math.floor(i / self.itemsPerPage)].push(self.filteredItems[i]);
                  }
              }
          };
          
          self.range = function (start, end) {
              var ret = [];
              if (!end) {
                  end = start;
                  start = 0;
              }
              for (var i = start; i < end; i++) {
                  ret.push(i);
              }
              return ret;
          };
          
          self.prevPage = function () {
              if (self.currentPage > 0) {
            	  self.currentPage--;
              }
          };
          
          self.nextPage = function () {
              if (self.currentPage < self.pagedItems.length - 1) {
            	  self.currentPage++;
              }
          };
          
          self.setPage = function (n) {
        	  self.currentPage = n;
          };
          
          self.fetchAllUsers();

      }]);
