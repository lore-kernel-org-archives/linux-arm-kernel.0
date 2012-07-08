From: tremyfr@yahoo.fr (Philippe Reynes)
Date: Sun,  8 Jul 2012 18:29:23 +0200
Subject: [PATCH] Add nand platform on imx27 devicetree
Message-ID: <1341764963-11402-1-git-send-email-tremyfr@yahoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philippe Reynes <tremyfr@yahoo.fr>
---
 arch/arm/mach-imx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index eff4db5..565422b 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -381,6 +381,7 @@ config MACH_IMX27_DT
 	bool "Support i.MX27 platforms from device tree"
 	select SOC_IMX27
 	select USE_OF
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for Freescale i.MX27 based platforms
 	  using the device tree for discovery
-- 
1.7.1
