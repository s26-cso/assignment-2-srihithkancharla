#include<stdio.h>
#include<dlfcn.h>
#include<string.h>

typedef int (*fptr)(int,int);

int main(){

    while(1){
        char op[20];
        int x,y;
        scanf("%s %d %d",op,&x,&y);
        char file[40] = "lib";
        strcat(file,op);
        strcat(file,".so");

        char arr[20] = "./";
        strcat(arr,file);

        void *handle = dlopen(arr,RTLD_LAZY);

        fptr func = dlsym(handle,op);

        printf("%d\n",func(x,y));

        dlclose(handle);
    }

    return 0;
}
