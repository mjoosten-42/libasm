#include "libasm.h"
#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>

void assert(int b);
void nop(void *data);
int cmp(void *, void *);

int main(int argc, char **argv) {
	/*
	char *str = "Hello world!\0Unreachable";
	printf("str: %p\n", str);
	size_t len = ft_strlen(str);
	printf("len: %lu\n", len);
	write(1, str, len);
	write(1, "\n", 1);
	*/

	/*
	char dest[] = "garbage";
	char data[] = "important data";
	const char *str = "Hello world!";
	ft_strcpy(dest, str);
	printf("dest: %s\n", dest);
	printf("data: %s\n", data);
	*/

	/*
	const char *s1 = "a";
	const char *s2 = "z";
	int cmp = ft_strcmp(s1, s2);
	int real = strcmp(s1, s2);
	printf("cmp:  %i\n", cmp);
	printf("real: %i\n", real);
	*/

	/*
	const char *str = "Hello world!\n";
	ssize_t ret = ft_write(-1, str, ft_strlen(str));
	if (ret == -1) { perror("ft_write"); }
	else { printf("ret: %li\n", ret); }

	char buf[1024] = { 0 };
	ret = ft_read(-1, buf, 1024);
	if (ret == -1) { perror("ft_read"); }
	else { printf("ret: %li\n", ret); }
	*/

	/*
	char *str = "Hello world!";
	char *copy = ft_strdup(str);

	if (copy) {
		ft_put("copy: ");
		ft_put(copy);
		ft_put("\n");
	}
	*/

	/*
	char *out = ft_strdup("Hello world!\n");

	if (out) {
		printf("%s", out);
		free(out);
	}
	*/

	/*
	if (argc >= 3){
		int nr = ft_atoi_base(argv[1], argv[2]);

		printf("nr: %i\n", nr);
	}
	*/

	t_list *lst = NULL;
	
	assert(ft_list_size(lst) == 0);

	ft_list_push_front(&lst, (void *)0x123);
	ft_list_push_front(&lst, (void *)0x789);
	ft_list_push_front(&lst, (void *)0x456);

	assert(ft_list_size(lst) == 3);
	assert(lst->data == (void *)0x456);
	assert(lst->next->data == (void *)0x789);
	assert(lst->next->next->data == (void *)0x123);
	assert(lst->next->next->next == NULL);

	/*
	ft_list_sort(&lst, cmp);

	assert(ft_list_size(lst) == 3);
	assert(lst->data == (void *)0x123);
	assert(lst->next->data == (void *)0x456);
	assert(lst->next->next->data == (void *)0x789);
	assert(lst->next->next->next == NULL);
	*/

	printf("nop: %p\n", nop);

	ft_list_remove_if(&lst, (void *)0x789, cmp, nop);

	assert(ft_list_size(lst) == 2);
	assert(lst->data == (void *)0x123);
	assert(lst->next->data == (void *)0x456);
	assert(lst->next->next == NULL);
	
	(void)argc, (void)argv;
}

void nop(void *data) {
	(void)data;
}

int cmp(void *f, void *g) {
	return f - g;
}

void assert(int b) {
	if (!b) {
		fprintf(stderr, "assert failed\n");
		abort();
	}
}

