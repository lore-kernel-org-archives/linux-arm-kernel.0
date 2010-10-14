From: arasv@magellan-technology.com (Aras Vaichas)
Date: Thu, 14 Oct 2010 17:13:34 +1100
Subject: ARM: "undefined reference to `wrong_size_cmpxchg'"
Message-ID: <AANLkTi=uvHax-NJ62AhKNEq70un_RUrVZZuhtzjFBg-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linux-2.6.33.7 + patch-2.6.33.7-rt29 + at91 patches

CPU is at91rm9200

I get the linker error:

kernel/built-in.o: In function `__tasklet_hi_schedule':
slow-work.c:(.text+0xca1c): undefined reference to `wrong_size_cmpxchg'
kernel/built-in.o: In function `__tasklet_schedule':
slow-work.c:(.text+0xcb7c): undefined reference to `wrong_size_cmpxchg'
kernel/built-in.o: In function `__tasklet_action':
slow-work.c:(.text+0xce4c): undefined reference to `wrong_size_cmpxchg'
kernel/built-in.o: In function `sched_init_smp':
slow-work.c:(.init.text+0xec): undefined reference to `____ilog2_NaN'
make: *** [.tmp_vmlinux1] Error 1

Can anyone suggest a solution?

Is RT Linux supported for my CPU?

Thanks in advance!

Aras
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101014/ea0084b5/attachment-0001.html>
