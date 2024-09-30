#include <sys/types.h>

extern char		*ft_strdup(const char *s);
extern size_t	ft_strlen(const char *s);
extern char		*ft_strcpy(char *dest, const char *str);
extern int		ft_strcmp(const char *s1, const char *s2);
extern ssize_t	ft_write(int fd, const void *buf, size_t count);
extern ssize_t	ft_read(int fd, void *buf, size_t count);

void ft_put(const char *str) {
	ft_write(1, str, ft_strlen(str));
}

int main(void) {
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

	ft_strdup("Hello world!");
}

