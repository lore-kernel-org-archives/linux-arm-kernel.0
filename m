From: stefan@agner.ch (Stefan Agner)
Date: Mon,  9 Mar 2015 17:38:50 +0100
Subject: [PATCH v2 4/6] ARM: vf610: enable NAND Flash Controller
In-Reply-To: <1425919132-13827-1-git-send-email-stefan@agner.ch>
References: <1425919132-13827-1-git-send-email-stefan@agner.ch>
Message-ID: <1425919132-13827-5-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the NAND Flash Controller driver which is part of the Vybrid
SoC by default.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c8dffce..182e30e 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -635,6 +635,7 @@ config SOC_VF610
 	select ARM_GIC
 	select PINCTRL_VF610
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select HAVE_NAND_VF610_NFC
 
 	help
 	  This enable support for Freescale Vybrid VF610 processor.
-- 
2.3.1
