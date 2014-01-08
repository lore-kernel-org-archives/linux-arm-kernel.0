From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Wed,  8 Jan 2014 18:07:21 -0500
Subject: [RFC 5/5] imx:vf610: Allow user to enable NAND controller for the
 VF610 SOC.
In-Reply-To: <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
Message-ID: <1389222441-4322-6-git-send-email-bpringlemeir@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index b0c6eb3..02902ca 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -842,6 +842,7 @@ config SOC_VF610
 	select PL310_ERRATA_588369 if CACHE_PL310
 	select PL310_ERRATA_727915 if CACHE_PL310
 	select PL310_ERRATA_769419 if CACHE_PL310
+	select HAVE_NAND_FSL_NFC
 
 	help
 	  This enable support for Freescale Vybrid VF610 processor.
-- 
1.8.0.2
