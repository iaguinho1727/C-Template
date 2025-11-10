#include "linked_list.h"
#include "hashmap.h"
#include "printing.h"
void test_can_use_single_nodes()
{
	SingleNode* new_node_1=create_single_node_int(234);
	SingleNode* new_node_2=create_single_node_int(50);
	SingleNode* new_node_3=create_single_node_int(7);
	new_node_1->next=new_node_2;
	new_node_2->next=new_node_3;
	destroy_single_node(&new_node_1);
	destroy_single_node(&new_node_2);
	destroy_single_node(&new_node_3);
	if(new_node_1!=NULL || new_node_2!=NULL || new_node_3!=NULL)
	{
		print_error("Failed to destroy all nodes");
		exit(1);
	}

}

void test_can_use_single_linked_list()
{
	SingleLinkedList* new_linked_list=create_single_linked_list();
	SINGLE_LINKED_LIST_APPEND(new_linked_list,int,234);
	single_linked_list_append(new_linked_list,create_single_node_int(34));
	
	single_linked_list_append(new_linked_list,create_single_node_int(10));
	print_single_linked_list(new_linked_list);
	destroy_single_linked_list(&new_linked_list);
}

int main()
{
	//test_can_use_single_nodes();
	test_can_use_single_linked_list();
	
	return 0;

	
}
