From: colin.tuckley@arm.com (Colin Tuckley)
Date: Mon, 25 Jan 2010 09:34:02 +0000
Subject: [PATCH] ARM: Remove the unused RealView mmc1 data structure.
Message-ID: <20100125093402.30530.22680.stgit@ARM03585.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-realview/core.c |    6 ------
 arch/arm/mach-realview/core.h |    1 -
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 81cf0aa..d6ebf8b 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -244,12 +244,6 @@ struct mmci_platform_data realview_mmc0_plat_data = {
 	.gpio_cd	= 16,
 };
 
-struct mmci_platform_data realview_mmc1_plat_data = {
-	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
-	.gpio_wp	= 19,
-	.gpio_cd	= 18,
-};
-
 /*
  * Clock handling
  */
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 781bca6..c136282 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -51,7 +51,6 @@ extern struct platform_device realview_flash_device;
 extern struct platform_device realview_cf_device;
 extern struct platform_device realview_i2c_device;
 extern struct mmci_platform_data realview_mmc0_plat_data;
-extern struct mmci_platform_data realview_mmc1_plat_data;
 extern struct clcd_board clcd_plat_data;
 extern void __iomem *gic_cpu_base_addr;
 extern void __iomem *timer0_va_base;
