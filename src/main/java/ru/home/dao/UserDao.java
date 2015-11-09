package ru.home.dao;

import java.util.List;

import ru.home.entity.User;
 
public interface UserDao {
 
    User findById(Long id);
 
    void saveUser(User user);
     
    void deleteUser(User user);
     
    List<User> findAllUsers();
 
}
