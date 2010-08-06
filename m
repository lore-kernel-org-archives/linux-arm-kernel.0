From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Fri, 6 Aug 2010 10:32:40 -0700 (PDT)
Subject: Impossible constraint in 'asm' in 2.6.35 build
Message-ID: <346052.84371.qm@web51008.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to build a 2.6.35 kernel for i.MX31 and I am getting the following error:

  CC      arch/arm/plat-mxc/audmux-v2.o
  CC      arch/arm/plat-mxc/3ds_debugboard.o
  CC      arch/arm/plat-mxc/devices/platform-imx-i2c.o
  CC      arch/arm/plat-mxc/devices/platform-imx-uart.o
  CC      arch/arm/plat-mxc/devices/platform-mxc_nand.o
  CC      arch/arm/plat-mxc/devices/platform-spi_imx.o
  LD      arch/arm/plat-mxc/devices/built-in.o
  LD      arch/arm/plat-mxc/built-in.o
  CC      arch/arm/vfp/vfpmodule.o
  AS      arch/arm/vfp/entry.o
  AS      arch/arm/vfp/vfphw.o
  LD      arch/arm/vfp/vfp.o
  LD      arch/arm/vfp/built-in.o
  CC      kernel/sched.o
kernel/sched_idletask.c: In function 'pick_next_task_idle':
/home/fabio/pengutronix/linux-2.6/arch/arm/include/asm/atomic.h:42: error: impossible constraint in 'asm'
make[1]: *** [kernel/sched.o] Error 1
make: *** [kernel] Error 2

I tried GCC4.3 and 4.4 and the result is the same. I haven't faced this issue when building 2.6.34.

Does anyone have any suggestion?

Thanks,

Fabio Estevam





      
