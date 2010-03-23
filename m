From: 914059751@qq.com (=?gbk?B?uvrR7sr3?=)
Date: Tue, 23 Mar 2010 20:57:55 +0800
Subject: Query about Float Point Operation
Message-ID: <tencent_1612D48D0AEC89DB53D9FFBB@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi , guys
I want to do float point operations in kernel like the following,

int foo(double d)
{

return (int)d*d;

}

while compiling output error msg like following:
cannt find eabi_dmul  balabla??????

May I ask any possibility of use float point operation in the kernel space?
Any hints/doc would be appreciated!
