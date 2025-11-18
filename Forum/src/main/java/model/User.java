package model;
import java.util.Date;

public class User {
    private String username;
    private String password;
    private String email;
    private Date joinDate;

    public User(String username, String password, String email) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.joinDate = new Date();
    }

    public boolean verify(String username, String password) {
        return this.username.equals(username) && this.password.equals(password);
    }
    
    // Getters and Setters
    public String getUsername() { return username; }
    public String getPassword() { return password; }
}