package ru.home.service;

import java.util.List;

import ru.home.entity.User;
 
public interface UserService {
 
    User findById(Long id);
     
    void saveUser(User user);
     
    void updateUser(User user);
     
    void deleteUser(User user);
 
    List<User> findAllUsers();

	boolean isUserExist(User user); 
     
     
}
