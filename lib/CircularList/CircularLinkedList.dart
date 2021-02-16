import 'dart:core';
import 'Node.dart';

class CircularLinkedList {

	Node head;
	Node tail;

	CircularLinkedList({List<dynamic> nodes})
	{
		addAllNodes(nodes);
	}

	void addAllNodes(List<dynamic> nodes)
	{
		for (dynamic node in nodes)
		{
			addNode(node);
		}
	}

	void addNode(dynamic value)
	{
		Node newNode = Node(value);
		if (head == null) {
			head = newNode;
		} else {
			tail.nextNode = newNode;
		}

		tail = newNode;
		tail.nextNode = head;
	}

	bool containsNode(dynamic searchValue) {
		Node currentNode = head;
		if (head == null) {
			return false;
		} else {
			do {
				if (currentNode.value == searchValue) {
					return true;
				}
				currentNode = currentNode.nextNode;
			} while (currentNode != head);
			return false;
		}
	}

	bool changeNodeHead(dynamic searchValue) {
		Node currentNode = head;
		if (head == null) {
			return false;
		} else {
			do {
				if (currentNode.value == searchValue) {
					head=currentNode;
					return true;
				}
				currentNode = currentNode.nextNode;
			} while (currentNode != head);
			return false;
		}
	}

	void deleteNode(dynamic valueToDelete) {
		Node currentNode = head;

		if (head != null) {
			if (currentNode.value == valueToDelete) {
				head = head.nextNode;
				tail.nextNode = head;
			} else {
				do {
					Node nextNode = currentNode.nextNode;
					if (nextNode.value == valueToDelete) {
						currentNode.nextNode = nextNode.nextNode;
						break;
					}
					currentNode = currentNode.nextNode;
				} while (currentNode != head);
			}
		}
	}

	void traverseList() {
		Node currentNode = head;
		if (head != null) {
			do {
				currentNode = currentNode.nextNode;
			} while (currentNode != head);
		}
	}

	List<dynamic> getNewList()
	{
		List<dynamic> nodes = List.empty(growable: true);
		Node currentNode = head;
		if (head != null) {
			do {
				nodes.add(currentNode.value);
				currentNode = currentNode.nextNode;
			} while (currentNode != head);
		}
		return nodes;
	}
}