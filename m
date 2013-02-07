From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 7 Feb 2013 09:47:58 -0200
Subject: mx28evk does not boot with linux-next 20130207
Message-ID: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When booting linux-next 20130207 I get no kernel console output on a
mx28evk. After selecting earlyprintk and CONFIG_DEBUG_LL=y support I
get:

  LD      vmlinux
  SORTEX  vmlinux
sort done marker at 514bcc
  SYSMAP  System.map
  OBJCOPY arch/arm/boot/Image
  Kernel: arch/arm/boot/Image is ready
  GZIP    arch/arm/boot/compressed/piggy.gzip
  AS      arch/arm/boot/compressed/debug.o
arch/arm/boot/compressed/debug.S: Assembler messages:
arch/arm/boot/compressed/debug.S:6: Error: garbage following
instruction -- `ldr
r2,=IOMEM((0xf4000000+((((0x80000000+0x074000))&0x80000000)>>7)+((((0x80000000+0x074000))&0x000fffff))))'

Is this a known issue?

Regards,

Fabio Estevam
