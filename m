From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 7 Nov 2011 23:49:46 -0200
Subject: Error for machine_is_m28evk
Message-ID: <CAOMZO5C4=ELWef8keoT8u0H8jTPRGQ5BA_8xYyKge++s+wdNqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On a 3.2-rc1 kernel I get the following error when trying to build
mxs_defconfig:

  CHK     include/generated/compile.h
  CC      arch/arm/mach-mxs/clock-mx28.o
arch/arm/mach-mxs/clock-mx28.c: In function 'clk_misc_init':
arch/arm/mach-mxs/clock-mx28.c:748: error: implicit declaration of
function 'machine_is_m28evk'
make[1]: *** [arch/arm/mach-mxs/clock-mx28.o] Error 1
make: *** [arch/arm/mach-mxs] Error 2

Regards,

Fabio Estevam
