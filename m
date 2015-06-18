From: stefan@agner.ch (Stefan Agner)
Date: Fri, 19 Jun 2015 00:58:37 +0200
Subject: [PATCH v6 4/6] ARM: vf610: enable NAND Flash Controller
In-Reply-To: <1434668319-6651-1-git-send-email-stefan@agner.ch>
References: <1434668319-6651-1-git-send-email-stefan@agner.ch>
Message-ID: <1434668319-6651-5-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the NAND Flash Controller driver which is part of the Vybrid
SoC by default.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 3a3d3e9..9358135 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -589,6 +589,7 @@ config SOC_VF610
 	select PINCTRL_VF610
 	select PL310_ERRATA_769419 if CACHE_L2X0
 	select SMP_ON_UP if SMP
+	select HAVE_NAND_VF610_NFC
 
 	help
 	  This enables support for Freescale Vybrid VF610 processor.
-- 
2.4.2
