From: axel.lin@gmail.com (Axel Lin)
Date: Wed, 14 Dec 2011 12:57:10 +0800
Subject: [linux-next] make  s5p64x0_defconfig build error
Message-ID: <1323838630.18517.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I got below build error on linux-next 20111213.

  CC      arch/arm/kernel/process.o
In file included from arch/arm/mach-s5p64x0/include/mach/system.h:16,
                 from arch/arm/kernel/process.c:64:
arch/arm/plat-samsung/include/plat/system-reset.h:19:2: error: #error Fix me up
make[1]: *** [arch/arm/kernel/process.o] Error 1
make: *** [arch/arm/kernel] Error 2

Regards,
Axel
