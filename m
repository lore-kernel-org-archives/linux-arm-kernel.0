From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Feb 2012 10:47:48 -0800
Subject: [PATCH v2 7/7] ARM: imx: remove macro MXC_GPIO_IRQ_START
In-Reply-To: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
References: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1329331668-30325-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, macro MXC_GPIO_IRQ_START is referenced nowhere, so remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/plat-mxc/include/mach/irqs.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index fd9efb0..612fcf1 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -28,8 +28,6 @@
 #define MXC_INTERNAL_IRQS	64
 #endif
 
-#define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
-
 /*
  * The next 16 interrupts are for board specific purposes.  Since
  * the kernel can only run on one machine at a time, we can re-use
-- 
1.7.5.4
