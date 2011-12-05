From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  5 Dec 2011 12:15:49 +0800
Subject: [PATCH 6/6] arm/imx: remove macro MXC_GPIO_IRQ_START
In-Reply-To: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
References: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1323058550-13368-8-git-send-email-shawn.guo@linaro.org>
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
1.7.4.1
