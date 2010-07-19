From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 19 Jul 2010 12:58:56 +0200
Subject: [PATCH 1/9] [ARM] pxa/spitz: remove unused declarations
Message-ID: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/include/mach/spitz.h |    8 --------
 arch/arm/mach-pxa/spitz.c              |    3 ---
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/spitz.h b/arch/arm/mach-pxa/include/mach/spitz.h
index fa1998c..dc1ff25 100644
--- a/arch/arm/mach-pxa/include/mach/spitz.h
+++ b/arch/arm/mach-pxa/include/mach/spitz.h
@@ -181,11 +181,3 @@
 #define SPITZ_IRQ_GPIO_CF2_IRQ        IRQ_GPIO(SPITZ_GPIO_CF2_IRQ)
 #define SPITZ_IRQ_GPIO_nSD_INT        IRQ_GPIO(SPITZ_GPIO_nSD_INT)
 #define SPITZ_IRQ_GPIO_nSD_DETECT     IRQ_GPIO(SPITZ_GPIO_nSD_DETECT)
-
-/*
- * Shared data structures
- */
-extern struct platform_device spitzscoop_device;
-extern struct platform_device spitzscoop2_device;
-extern struct platform_device spitzssp_device;
-extern struct sharpsl_charger_machinfo spitz_pm_machinfo;
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index c1048a3..ddf7a11 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -242,9 +242,6 @@ static struct scoop_pcmcia_config spitz_pcmcia_config = {
 	.power_ctrl   = spitz_pcmcia_pwr,
 };
 
-EXPORT_SYMBOL(spitzscoop_device);
-EXPORT_SYMBOL(spitzscoop2_device);
-
 /*
  * Spitz Keyboard Device
  */
-- 
1.7.1
