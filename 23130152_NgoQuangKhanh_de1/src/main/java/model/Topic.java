package model;

import java.util.Stack;

public class Topic extends Entry {
	private Stack<Message> messages;

	public Topic(String title, String content, User creator) {
		super(title, content, creator);
		this.messages = new Stack<>();
	}

	public void addMessage(Message message) {
		this.messages.push(message);
	}

	public Message getNewMessage() {
		if (messages.isEmpty())
			return null;
		return messages.peek();
	}

	public Stack<Message> getMessages() {
		return messages;
	}

	public int getReplyCount() {
		return messages.size();
	}
}