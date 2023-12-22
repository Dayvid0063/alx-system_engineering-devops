#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <time.h>

/**
 * infinite_while - Func makes an infinite loop
 * Return: 0
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}

/**
 * main - Program that creates 5 zombie processes
 * Return: 0
 */
int main(void)
{
	int u;
	pid_t z;

	for (u = 0; u < 5; u++)
	{
		z = fork();
		if (!z)
			return (0);
		printf("Zombie process created, PID: %d\n", z);
	}

	infinite_while();
	return (0);
}
