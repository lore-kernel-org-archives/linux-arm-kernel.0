From: alex@gai.ru (Alex Sverdlin)
Date: Thu, 07 Oct 2010 22:48:49 +0400
Subject: 2.6.36-rc7-next-20101007 failed to compile (arch/arm/kernel/setup.c)
Message-ID: <4CAE1611.1020105@gai.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

make output:
...
  CC      arch/arm/kernel/ptrace.o
  CC      arch/arm/kernel/return_address.o
  CC      arch/arm/kernel/setup.o
/tmp/cccRqJQQ.s: Assembler messages:
/tmp/cccRqJQQ.s:571: Error: bad instruction `isb'
make[2]: *** [arch/arm/kernel/setup.o] Error 1
make[1]: *** [arch/arm/kernel] Error 2
...

2.6.36-rc6 compiled without this problem...

Compiler is GCC 3.4.3, complete toolchain taken from
http://arm.cirrus.com/files/tools/arm-linux-gcc-3.4.3-1.0.1.tar.bz2
