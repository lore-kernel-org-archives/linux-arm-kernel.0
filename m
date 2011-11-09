From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 8 Nov 2011 22:27:29 -0200
Subject: Broken mx5_defconfig on 3.2-rc1
Message-ID: <CAOMZO5Bth-dKSY9S6o=waYLMrzdx-Tc4E+VshGHvWo5bVC+fKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Building mx5_defconfig on 3.2-rc1 I get:

  CHK     include/generated/compile.h
  CC      arch/arm/mach-mx5/clock-mx51-mx53.o
arch/arm/mach-mx5/clock-mx51-mx53.c: In function 'clk_get_freq_dt':
arch/arm/mach-mx5/clock-mx51-mx53.c:1644: error: implicit declaration
of function 'for_each_compatible_node'
arch/arm/mach-mx5/clock-mx51-mx53.c:1644: error: expected ';' before '{' token
make[1]: *** [arch/arm/mach-mx5/clock-mx51-mx53.o] Error 1
make: *** [arch/arm/mach-mx5] Error 2

Regards,

Fabio Estevam
