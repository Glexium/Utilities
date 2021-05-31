import 'dart:core';
import 'Node.dart';

class CircularLinkedList {

	Node? head;
	late Node tail;

	/// Initiates [CircularLinkedList] with optional nodes.
	///
	/// This list of nodes is dynamic, so it can be any type of value.
	CircularLinkedList({required List<dynamic> nodes})
	{
		addAllNodes(nodes);
	}

	/// Add a list of nodes to the [CircularLinkedList]
	///
	/// This list of nodes is dynamic, so it can be any type of value.
	void addAllNodes(List<dynamic> nodes)
	{
		for (dynamic node in nodes)
		{
			addNode(node);
		}
	}

	/// Add a node to the [CircularLinkedList]
	///
	/// This node is dynamic, so it can be any type of value.
	/// The first entry of the [CircularLinkedList] it will be the [head] and [tail],
	/// next entries will update [tail] and [tail.nextNode] to [head].
	void addNode(dynamic value)
	{
		Node newNode = Node(value);
		if (head == null)
			head = newNode;
		else
			tail.nextNode = newNode;
		tail = newNode;
		tail.nextNode = head;
	}

	/// Returns 'true' if [searchValue] is found inside the [CircularLinkedList]
	///
	/// The first node [currentNode] will start with the value of [head],
	/// It checks all nodes one by one for [searchValue] while [currentNode] is not the same as [head]
	/// if it is found return 'true', if not update [currentNode] with [currentNode.nextNode],
	/// if [searchValue] is not found it returns 'false'.
	bool containsNode(dynamic searchValue) {
		Node? currentNode = head;
		if (head == null)
			return false;
		else {
			do {
				if (currentNode!.value == searchValue) {
					return true;
				}
				currentNode = currentNode.nextNode;
			} while (currentNode != head);
			return false;
		}
	}

	/// Returns 'true' if [newHead] is successfully changed
	///
	/// The first node [currentNode] will start with the value of [head],
	/// It checks all nodes one by one for [newHead] while [currentNode] is not the same as [head]
	/// if it is found it changes the value of [head] and then return 'true',
	/// if not update [currentNode] with [currentNode.nextNode],
	/// if [newHead] is not found it returns 'false'.
	bool changeNodeHead(dynamic newHead) {
		Node? currentNode = head;
		if (head == null) {
			return false;
		} else {
			do {
				if (currentNode!.value == newHead) {
					head=currentNode;
					return true;
				}
				currentNode = currentNode.nextNode;
			} while (currentNode != head);
			return false;
		}
	}

	/// This deletes a node from the [CircularLinkedList] if [valueToDelete] is found.
	///
	/// The first node [currentNode] will start with the value of [head],
	/// It checks if [currentValue] is the same as [valueToDelete]
	/// if they are the same then [tail.nextNode] takes the value of [head.nextNode],
	/// this changes the [CircularLinkedList] removing [valueToDelete]
	/// if not then it checks all nodes one by one for [valueToDelete] while [currentNode] is not the same as [head]
	/// then if it is found it changes the value of [currentNode.nextNode] with [nextNode.nextNode].
	void deleteNode(dynamic valueToDelete) {
		Node? currentNode = head;
		if (head != null) {
			if (currentNode!.value == valueToDelete) {
				//Note, check if tail.nextNode = head.nextNode works the same
				head = head!.nextNode;
				tail.nextNode = head;
			} else {
				do {
					Node nextNode = currentNode!.nextNode!;
					if (nextNode.value == valueToDelete) {
						currentNode.nextNode = nextNode.nextNode;
						break;
					}
					currentNode = currentNode.nextNode;
				} while (currentNode != head);
			}
		}
	}

	/// This traverse the entire list and it print each value
	///
	/// It prints all nodes of [CircularLinkedList]
	void traverseList() {
		Node? currentNode = head;
		if (head != null) {
			do {
				currentNode = currentNode!.nextNode;
				print(currentNode);
			} while (currentNode != head);
		}
	}

	/// Returns a list of all nodes.
	///
	/// It creates an empty dynamic list, then it traverse all the [CircularLinkedList]
	/// and added to the list each element, finally it returns this list.
	List<dynamic> getNewList()
	{
		List<dynamic> nodes = List.empty(growable: true);
		Node? currentNode = head;
		if (head != null) {
			do {
				nodes.add(currentNode!.value);
				currentNode = currentNode.nextNode;
			} while (currentNode != head);
		}
		return nodes;
	}
}