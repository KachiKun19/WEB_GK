package service;

import model.*;
import java.util.*;

public class ForumService {
	private static Map<String, User> users = new HashMap<>();
	private static List<Topic> topics = new ArrayList<>();

	static {
		User u1 = new User("chuotcon", "chuotcon", "chuot@mail.com");
		User u2 = new User("admin", "123", "admin@mail.com");
		users.put(u1.getUsername(), u1);
		users.put(u2.getUsername(), u2);

		Topic t1 = new Topic("Chuyện học phí!!!", "Tại sao học phí tăng?", u1);
		t1.addMessage(new Message("Re: Chuyện học phí", "Đồng ý", u2));
		topics.add(t1);

		Topic t2 = new Topic("Học phí trái buổi", "Học phí cao quá", u2);
		topics.add(t2);
	}

	public static User checkUser(String username, String password) {
		User user = users.get(username);
		if (user != null && user.verify(username, password)) {
			return user;
		}
		return null;
	}

	public static List<Topic> getTopics() {
		return topics;
	}

	public static void addTopic(Topic t) {
		topics.add(t);
	}

	public static Topic findTopicById(long id) {
		for (Topic t : topics) {
			if (t.getId() == id) {
				return t;
			}
		}
		return null;
	}
}