From: anilk4.v@gmail.com (Anil Kumar)
Date: Sun, 8 Sep 2013 11:34:10 +0530
Subject: Build error in torvalds kernel 3.11 for omap2plus
Message-ID: <CABYxbz7m4GdHFNY3fP1Cpv3a_dNTSozdd7dX9yLG6vQ3zZxu9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I am getting below build error in torvalds kernel 3.11 for omap2plus.


scripts/kconfig/conf --silentoldconfig Kconfig
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  AS      arch/arm/mm/cache-v7.o
arch/arm/mm/cache-v7.S: Assembler messages:
arch/arm/mm/cache-v7.S:285: Error: garbage following instruction -- `dsb ishst'
arch/arm/mm/cache-v7.S:297: Error: garbage following instruction -- `dsb ishst'
make[1]: *** [arch/arm/mm/cache-v7.o] Error 1
make: *** [arch/arm/mm] Error 2

Thanks
Anil
