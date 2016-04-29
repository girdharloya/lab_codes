#ifndef __NODE_H__
#define __NODE_H__

#include<bits/stdc++.h>
using namespace std;

struct node
{
	int *truelist;
	int *falselist;
	int cnt1;
	int cnt2;
	node()
	{
		truelist=new int[100];
		falselist=new int[100];
		cnt1=0;
		cnt2=0;
	}
};

void backpatch(int *a,int cnt,int num);
int* mergeList(int* a,int* b,int cnt1,int cnt2);
void printcode();
void calc();

#endif
