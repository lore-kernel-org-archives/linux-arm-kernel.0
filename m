From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 8 Nov 2011 22:32:51 -0200
Subject: Broken imx_v4_v5_defconfig on 3.2-rc1
Message-ID: <CAOMZO5BuC5CvY=K=OPVB3pA39u2ASua8OrxMMvoW04wg3V4qng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building  imx_v4_v5_defconfig on 3.2-rc1:

  CC      arch/arm/plat-mxc/irq-common.o
  CC      arch/arm/plat-mxc/avic.o
arch/arm/plat-mxc/avic.c:155: error: expected '=', ',', ';', 'asm' or
'__attribute__' before 'avic_handle_irq'
make[1]: *** [arch/arm/plat-mxc/avic.o] Error 1
make: *** [arch/arm/plat-mxc] Error 2

BTW, too bad that no i.MX can be built on 3.2-rc1

Regards,

Fabio Estevam
