#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include "libasm.h"
#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>

#define ASSERT(EX) (void)((EX) || fprintf(stderr, "Assertion failed: " #EX " at " __FILE__ ":%d\n",__LINE__))
#define SIZEOF(array) (int)(sizeof(array)/sizeof(*array))

void nop(void *data) {
	(void)data;
}

int cmp(void *f, void *g) {
	return f - g;
}

int lt(void *f, void *g) {
	return f < g ? 0 : 1;
}

int main() {
	t_list *lst = NULL;

	char *strs[] = {
		"",
		"a",
		"bc",
		"d\0e",
		"a slightly longer string",
	};

	// ft_strlen
	for (int i = 0; i < SIZEOF(strs); i++) {
		ASSERT(strlen(strs[i]) == ft_strlen(strs[i]));
	}

	// ft_strcpy
	char dest[]		= "xxxxxxxxxxxxxxxxxxxxx";
	const char *str	= "Hello world!";
	ft_strcpy(dest, str);
	ASSERT(!strcmp(dest, str));

	// ft_strcmp
	ASSERT(strcmp(strs[0], strs[0]) == ft_strcmp(strs[0], strs[0]));
	ASSERT(strcmp("a", "b") == ft_strcmp("a", "b"));
	ASSERT(strcmp("c", "b") == ft_strcmp("c", "b"));
		
	// ft_write and ft_read
	int fds[2];
	char buf1[1024] = { 0 };
	char buf2[1024] = { 0 };
	
	pipe(fds);

	for (int i = 0; i < SIZEOF(strs); i++) {
		write(fds[1], strs[i], strlen(strs[i]));
	}

	read(fds[0], buf1, 1024);
	
	for (int i = 0; i < SIZEOF(strs); i++) {
		ft_write(fds[1], strs[i], ft_strlen(strs[i]));
	}

	read(fds[0], buf2, 1024);
	
	ASSERT(!strncmp(buf1, buf2, 1024));

	ASSERT(ft_read(-1, NULL, 1) == -1);
	ASSERT(errno == EBADF);

	ASSERT(ft_write(-1, NULL, 1) == -1);
	ASSERT(errno == EBADF);

	// ft_strdup
	char *copy = ft_strdup(str);

	if (copy) {
		ASSERT(!strcmp(str, copy));
		free(copy);
	}

	copy = ft_strdup("");

	if (copy) {
		ASSERT(!strcmp("", copy));
		free(copy);
	}

	// ft_atoi_base
	ASSERT(ft_atoi_base("00101010", "") == 0);
	ASSERT(ft_atoi_base("00101010", "0") == 0);
	ASSERT(ft_atoi_base("00101010", "01+") == 0);
	ASSERT(ft_atoi_base("00101010", "01-") == 0);
	ASSERT(ft_atoi_base("00101010", "01 ") == 0);
	ASSERT(ft_atoi_base("00101010", "01\t") == 0);
	ASSERT(ft_atoi_base("00101010", "01\n") == 0);

	ASSERT(ft_atoi_base("00101010", "01") == 42);
	ASSERT(ft_atoi_base("42", "0123456789") == 42);
	ASSERT(ft_atoi_base("2A", "0123456789abcdef") == 42);

	ASSERT(ft_atoi_base("   +42", "0123456789") == 42);
	ASSERT(ft_atoi_base("   -42", "0123456789") == -42);
	ASSERT(ft_atoi_base("   +--+-42", "0123456789") == -42);
	ASSERT(ft_atoi_base("   \t42", "0123456789") == 42);

	ASSERT(ft_atoi_base("c42", "0123456789") == 0);
	ASSERT(ft_atoi_base(" c42", "0123456789") == 0);
	ASSERT(ft_atoi_base(" +c42", "0123456789") == 0);



	// ft_list_remove_if
	ft_list_remove_if(&lst, (void *)0x789, cmp, nop);
	ASSERT(lst == NULL);

	ft_list_push_front(&lst, (void *)0x789);
	ft_list_push_front(&lst, (void *)0x456);
	ft_list_push_front(&lst, (void *)0x123);

	ft_list_remove_if(&lst, (void *)0x456, cmp, nop);
	ASSERT(ft_list_size(lst) == 2);
	ASSERT(lst->next->data == (void *)0x789);

	ft_list_remove_if(&lst, (void *)-1, lt, nop);
	ASSERT(lst == NULL);
	
	ft_list_push_front(&lst, (void *)0x456);
	ft_list_remove_if(&lst, (void *)0x123, cmp, nop);
	ASSERT(lst->data == (void *)0x456);

	ft_list_push_front(&lst, (void *)0x123);
	ft_list_remove_if(&lst, (void *)0x123, cmp, nop);
	ASSERT(lst->data == (void *)0x456);

	// ft_list_sort
	lst = NULL;

	ft_list_sort(&lst, cmp);
	ASSERT(lst == NULL);

	ft_list_push_front(&lst, (void *)0x123);
	ft_list_push_front(&lst, (void *)0x456);
	ft_list_push_front(&lst, (void *)0x789);

	ft_list_sort(&lst, cmp);
	ASSERT(lst->data == (void *)0x123);
	ASSERT(lst->next->data == (void *)0x456);
	ASSERT(lst->next->next->data == (void *)0x789);

	ft_list_sort(&lst, cmp);
	ASSERT(lst->data == (void *)0x123);
	ASSERT(lst->next->data == (void *)0x456);
	ASSERT(lst->next->next->data == (void *)0x789);
}

