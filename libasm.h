#ifndef LIBASM_H
#define LIBASM_H

#include <sys/types.h>

typedef struct		s_list {
	struct s_list	*next;
	void			*data;
}					t_list;

char	*ft_strdup(const char *s);
size_t	ft_strlen(const char *s);
char	*ft_strcpy(char *dest, const char *str);
int		ft_strcmp(const char *s1, const char *s2);
ssize_t	ft_write(int fd, const void *buf, size_t count);
ssize_t	ft_read(int fd, void *buf, size_t count);

int		ft_atoi_base(const char *str, const char *base);
void	ft_list_push_front(t_list **lst, void *data);
int		ft_list_size(t_list *lst);
void	ft_list_sort(t_list **lst, int (*cmp)());
void	ft_list_remove_if(t_list **lst, void *data, int (*cmp)(), void (*free)(void *));

#endif
