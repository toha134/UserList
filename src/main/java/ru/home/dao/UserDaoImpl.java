package ru.home.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.springframework.stereotype.Repository;
 
import ru.home.entity.User;

@Repository("userDao")
public class UserDaoImpl extends AbstractDao<Long, User> implements UserDao {
 
    public User findById(Long id) {
        return getByKey(id);
    }
 
    public void saveUser(User user) {
        persist(user);
    }
 
    public void deleteUser(User user) {
        delete(user);
    }
 
    @SuppressWarnings("unchecked")
    public List<User> findAllUsers() {
        Criteria criteria = createEntityCriteria();
        return (List<User>) criteria.list();
    }
 
}