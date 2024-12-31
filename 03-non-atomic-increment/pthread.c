#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

int count = 0;
void* threadFunc(void* arg) {
    count ++;
    return NULL;
}

int main() {
    pthread_t t1, t2;
    pthread_create(&t1, NULL, threadFunc, NULL);
    pthread_create(&t2, NULL, threadFunc, NULL);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    pthread_create(&t2, NULL, threadFunc, NULL);
    pthread_join(t1, NULL);
    printf("count: %d\n", count);
    return 0;
}