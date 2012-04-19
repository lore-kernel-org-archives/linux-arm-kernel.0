From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Apr 2012 19:20:36 -0700
Subject: [PATCH 7/7] ARM: SAMSUNG: move options for common s5p into
 plat-samsung/Kconfig
In-Reply-To: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
References: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1334802036-16768-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/Kconfig     |   65 -----------------------------------------
 arch/arm/plat-samsung/Kconfig |   65 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 4ff6d7e..e7d5d77 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -22,68 +22,3 @@ config PLAT_S5P
 	select SAMSUNG_IRQ_VIC_TIMER
 	help
 	  Base platform code for Samsung's S5P series SoC.
-
-config S5P_DEV_FIMC0
-	bool
-	help
-	  Compile in platform device definitions for FIMC controller 0
-
-config S5P_DEV_FIMC1
-	bool
-	help
-	  Compile in platform device definitions for FIMC controller 1
-
-config S5P_DEV_FIMC2
-	bool
-	help
-	  Compile in platform device definitions for FIMC controller 2
-
-config S5P_DEV_FIMC3
-	bool
-	help
-	  Compile in platform device definitions for FIMC controller 3
-
-config S5P_DEV_JPEG
-	bool
-	help
-	  Compile in platform device definitions for JPEG codec
-
-config S5P_DEV_G2D
-	bool
-	help
-	  Compile in platform device definitions for G2D device
-
-config S5P_DEV_FIMD0
-	bool
-	help
-	  Compile in platform device definitions for FIMD controller 0
-
-config S5P_DEV_I2C_HDMIPHY
-	bool
-	help
-	  Compile in platform device definitions for I2C HDMIPHY controller
-
-config S5P_DEV_ONENAND
-	bool
-	help
-	  Compile in platform device definition for OneNAND controller
-
-config S5P_DEV_CSIS0
-	bool
-	help
-	  Compile in platform device definitions for MIPI-CSIS channel 0
-
-config S5P_DEV_CSIS1
-	bool
-	help
-	  Compile in platform device definitions for MIPI-CSIS channel 1
-
-config S5P_DEV_TV
-	bool
-	help
-	  Compile in platform device definition for TV interface
-
-config S5P_DEV_USB_EHCI
-	bool
-	help
-	  Compile in platform device definition for USB EHCI
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index cfa62e8..b3160c9 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -309,11 +309,76 @@ config SAMSUNG_DEV_BACKLIGHT
 	help
 	  Compile in platform device definition LCD backlight with PWM Timer
 
+config S5P_DEV_CSIS0
+	bool
+	help
+	  Compile in platform device definitions for MIPI-CSIS channel 0
+
+config S5P_DEV_CSIS1
+	bool
+	help
+	  Compile in platform device definitions for MIPI-CSIS channel 1
+
+config S5P_DEV_FIMC0
+	bool
+	help
+	  Compile in platform device definitions for FIMC controller 0
+
+config S5P_DEV_FIMC1
+	bool
+	help
+	  Compile in platform device definitions for FIMC controller 1
+
+config S5P_DEV_FIMC2
+	bool
+	help
+	  Compile in platform device definitions for FIMC controller 2
+
+config S5P_DEV_FIMC3
+	bool
+	help
+	  Compile in platform device definitions for FIMC controller 3
+
+config S5P_DEV_FIMD0
+	bool
+	help
+	  Compile in platform device definitions for FIMD controller 0
+
+config S5P_DEV_G2D
+	bool
+	help
+	  Compile in platform device definitions for G2D device
+
+config S5P_DEV_I2C_HDMIPHY
+	bool
+	help
+	  Compile in platform device definitions for I2C HDMIPHY controller
+
+config S5P_DEV_JPEG
+	bool
+	help
+	  Compile in platform device definitions for JPEG codec
+
 config S5P_DEV_MFC
 	bool
 	help
 	  Compile in setup memory (init) code for MFC
 
+config S5P_DEV_ONENAND
+	bool
+	help
+	  Compile in platform device definition for OneNAND controller
+
+config S5P_DEV_TV
+	bool
+	help
+	  Compile in platform device definition for TV interface
+
+config S5P_DEV_USB_EHCI
+	bool
+	help
+	  Compile in platform device definition for USB EHCI
+
 config S3C24XX_PWM
 	bool "PWM device support"
 	select HAVE_PWM
-- 
1.7.2.3
