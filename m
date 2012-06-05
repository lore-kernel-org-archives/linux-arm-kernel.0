From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 5 Jun 2012 15:47:27 +0800
Subject: multiple target patterns issue while making kernel
Message-ID: <CAN1soZzFpGPAO8-D9wH18v-fmRR1PDcU2JFiPkWRzbps69knhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Did you ever meet make this kind of issue on v3.5-rc1?

hzhuang1 at sh4-dt-906:~/workspace/kernel/linux.git$ make clean
/home/hzhuang1/workspace/kernel/linux.git/usr/Makefile:58: ***
multiple target patterns.  Stop.
make: *** [_clean_usr] Error 2

I met this issue while I was executing "make" or "make clean" on
pxa/mmp/omap in arch-arm.

I didn't meet this issue on v3.4.

Regards
Haojian
