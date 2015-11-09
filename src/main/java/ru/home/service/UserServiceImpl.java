package ru.home.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
 
import ru.home.dao.UserDao;
import ru.home.entity.User;
 
@Service("userService")
@Transactional
public class UserServiceImpl implements UserService {
 
    @Autowired
    private UserDao dao;
     
    public User findById(Long id) {
        return dao.findById(id);
    }
 
    public void saveUser(User user) {
        dao.saveUser(user);
    }
 
    /*
     * Since the method is running with Transaction, No need to call hibernate update explicitly.
     * Just fetch the entity from db and update it with proper values within transaction.
     * It will be updated in db once transaction ends. 
     */
    public void updateUser(User user) {
        User entity = dao.findById(user.getId());
        if(entity!=null){
            entity.setName(user.getName());
            entity.setCreatedDate(user.getCreatedDate());
            entity.setAge(user.getAge());
            entity.setAdmin(user.isAdmin());
        }
    }
 
    public void deleteUser(User user) {
        dao.deleteUser(user);
    }
     
    public List<User> findAllUsers() {
        return dao.findAllUsers();
    }

	public boolean isUserExist(User user) {
		if (user.getId() == null)
			return false;
		User existsUser = dao.findById(user.getId());
		return existsUser != null;
	}
    
    
    
}
