From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 05 Feb 2010 20:15:15 +0900
Subject: [PATCH 04/06] sh: Build drivers/sh for SuperH Mobile ARM
In-Reply-To: <20100205111440.17065.33296.sendpatchset@rxone.opensource.se>
References: <20100205111440.17065.33296.sendpatchset@rxone.opensource.se>
Message-ID: <20100205111515.17065.49828.sendpatchset@rxone.opensource.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Build drivers/sh in the case for SuperH Mobile ARM.
Shared code for the interrupt controller (INTC) and
the gpio/pinmux (PFC) is located there.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- 0001/drivers/Makefile
+++ work/drivers/Makefile	2010-01-19 15:39:21.000000000 +0900
@@ -99,6 +99,7 @@ obj-$(CONFIG_SGI_SN)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
+obj-$(CONFIG_ARCH_SHMOBILE)	+= sh/
 obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
 obj-$(CONFIG_DMA_ENGINE)	+= dma/
 obj-$(CONFIG_DCA)		+= dca/
