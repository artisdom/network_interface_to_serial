// stdafx.cpp : ֻ������׼�����ļ���Դ�ļ�
// eth_win_static.pch ����ΪԤ����ͷ
// stdafx.obj ������Ԥ����������Ϣ

#include "stdafx.h"

// TODO: �� STDAFX.H ��
// �����κ�����ĸ���ͷ�ļ����������ڴ��ļ�������
// eth_win.cpp : ���� DLL Ӧ�ó���ĵ���������
//

#include "stdafx.h"


/*-------------------------------------------------------------------------*/
/**
   @file    eth.c
   @author  g.m 

   create on: 2014�� 7�� 21�� 
*/
/*--------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------
                                Includes
 ---------------------------------------------------------------------------*/

#ifndef __INIT_SOCK_H__
#define __INIT_SOCK_H__ 

#include <winsock2.h>

#pragma comment(lib, "WS2_32")
class CInitSock
{
public:
	CInitSock(BYTE minorVer = 2, BYTE majorVer = 2)
	{
		WSADATA wsaData;
		WORD sockVersion = MAKEWORD(minorVer, majorVer);
		//VERIFY(::WSAStartup(sockVersion, &wsaData)==0);
		WSAStartup(sockVersion, &wsaData);
	}

	~CInitSock()
	{
		::WSACleanup();
	}
};
#endif // __INIT_SOCK_H__

/*---------------------------------------------------------------------------
                            Function codes
 ---------------------------------------------------------------------------*/
int create_socket_stream_r()
{
	int sd;
	int val;

	sd = socket(AF_INET, SOCK_STREAM , IPPROTO_IP);
	if(sd < 0)
	{
		perror("socket:\r\n");	
		exit(-1);
	}

	val = 1;
	/*
	ret = setsockopt(sd,  SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
	if(ret != 0)
	{
		perror("setsockopt:\r\n");	
		exit(-1);
	}*/

	return sd;
}
int open_socket()
{
	return create_socket_stream_r();
}

// ��ʼ��
void init_sockaddr_in(int sa, char* ipstr, int portnum, struct sockaddr_in *addr)
{
	addr->sin_family = sa; 
	addr->sin_port = htons(portnum);   /* port in network byte order */
	addr->sin_addr.S_un.S_addr = inet_addr(ipstr);
}


int connect_plx(char *ipstr, int pot)
{
	int sockfd;
	int ret;
	struct sockaddr_in raddr;
	
	if((sockfd = open_socket()) < 0)
		return -1;

	init_sockaddr_in(AF_INET, ipstr, pot, &raddr);

	//���ӷ����
	while(1) {
		//�����׽���
		ret = connect(sockfd, (struct sockaddr*)&raddr, sizeof(raddr));
		//��������δ����,�Զ�����
		if(ret != 0) {
			continue;
		}
		if(ret != 0) {
			perror("connect failed:");	
			//���]���д򿪵Ĵ��� 
			closesocket(sockfd);
			return -1;
		}
		break;
	}

	return sockfd;
}


//��ȡ�׽Y�ַ�������Ϣ
int read_socket(int sockfd, char *des, int len)
{
	int ret;

	memset(des , '\0', len);

	ret = recv(sockfd, des, len, MSG_WAITALL);
	if(ret < 0) {
	perror("read: ");	
			return -1;
	} 
		

	return ret; 
}

//ͨ���׽Y�ַ�����Ϣ
int write_socket(int fd, char *src, int len)
{
	return send(fd, src, len, 0);
}

//���]�׽Y��
void close_socket(int fd)
{
	closesocket(fd);
}