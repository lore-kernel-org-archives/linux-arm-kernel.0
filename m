From: denis@eukrea.com (Denis Carikli)
Date: Thu, 17 Oct 2013 17:02:16 +0200
Subject: [Patch v2][ 18/37] ARM: imx{25,
 27} DT: Permit the selection of the imxfb framebuffer driver.
In-Reply-To: <1382022155-21954-1-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
Message-ID: <1382022155-21954-19-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Eric B?nard <eric@eukrea.com>

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/mach-imx/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7400c7b..43eafb1 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -254,6 +254,7 @@ endchoice
 config MACH_IMX25_DT
 	bool "Support i.MX25 platforms from device tree"
 	select SOC_IMX25
+	select IMX_HAVE_PLATFORM_IMX_FB
 	help
 	  Include support for Freescale i.MX25 based platforms
 	  using the device tree for discovery
@@ -442,6 +443,7 @@ config MACH_IMX27IPCAM
 config MACH_IMX27_DT
 	bool "Support i.MX27 platforms from device tree"
 	select SOC_IMX27
+	select IMX_HAVE_PLATFORM_IMX_FB
 	help
 	  Include support for Freescale i.MX27 based platforms
 	  using the device tree for discovery
-- 
1.7.9.5
