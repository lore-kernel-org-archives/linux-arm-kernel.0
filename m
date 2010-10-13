From: gadiyar@ti.com (Anand Gadiyar)
Date: Wed, 13 Oct 2010 18:53:08 +0530
Subject: linux-next: omap2plus_defconfig does not build
Message-ID: <a36d6a1047d959af6ea65cd7edacf6a8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building omap2plus_defconfig (which enables support for
OMAP2420/2430/OMAP3
and OMAP4 in one image), I get the following build error.

  CC      arch/arm/kernel/swp_emulate.o
/tmp/ccg979qz.s: Assembler messages:
/tmp/ccg979qz.s:343: Error: selected processor does not support ARM mode
`ldrexb r6,[r5]'
/tmp/ccg979qz.s:344: Error: selected processor does not support ARM mode
`strexb r1,r3,[r5]'
make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
make: *** [arch/arm/kernel] Error 2

I'm using CodeSourcery's 2010q1-202 toolchain based on gcc 4.4.1.

I haven't been following the lists closely the last few days, so I'm not
sure if this is a known issue. Just reporting it for now.

- Anand
