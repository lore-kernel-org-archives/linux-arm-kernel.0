From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 11 Feb 2012 09:14:32 -0800
Subject: [PATCH 8/8] ARM: imx: remove macro MXC_GPIO_IRQ_START
In-Reply-To: <1328980472-11923-1-git-send-email-shawn.guo@linaro.org>
References: <1328980472-11923-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1328980472-11923-9-git-send-email-shawn.guo@linaro.org>
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
