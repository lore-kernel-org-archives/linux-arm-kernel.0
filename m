From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 5 Jun 2012 16:15:37 +0800
Subject: multiple target patterns issue while making kernel
In-Reply-To: <CAN1soZzFpGPAO8-D9wH18v-fmRR1PDcU2JFiPkWRzbps69knhg@mail.gmail.com>
References: <CAN1soZzFpGPAO8-D9wH18v-fmRR1PDcU2JFiPkWRzbps69knhg@mail.gmail.com>
Message-ID: <CAN1soZx2snn6Hqn8rPKF8UfA6zCum8zieaZmkGXFjdN+0+3egg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I tried arm-eabi and arm-none-linux-gnueabi-4.4.1 toolchain on my
64-bit machine. And I
always got this error.

On Tue, Jun 5, 2012 at 3:47 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> Hi all,
>
> Did you ever meet make this kind of issue on v3.5-rc1?
>
> hzhuang1 at sh4-dt-906:~/workspace/kernel/linux.git$ make clean
> /home/hzhuang1/workspace/kernel/linux.git/usr/Makefile:58: ***
> multiple target patterns. ?Stop.
> make: *** [_clean_usr] Error 2
>
> I met this issue while I was executing "make" or "make clean" on
> pxa/mmp/omap in arch-arm.
>
> I didn't meet this issue on v3.4.
>
> Regards
> Haojian
