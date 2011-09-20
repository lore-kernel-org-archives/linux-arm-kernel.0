From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Tue, 20 Sep 2011 11:15:46 +0530
Subject: [PATCH] mach-ux500: enable fix for ARM errata 754322
Message-ID: <20110920054542.GA12962@bnru02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This applies ARM errata fix 754322 for all ux500 platforms.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 4210cb4..a3e0c86 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -6,6 +6,7 @@ config UX500_SOC_COMMON
 	select ARM_GIC
 	select HAS_MTU
 	select ARM_ERRATA_753970
+	select ARM_ERRATA_754322
 
 menu "Ux500 SoC"
 
-- 
1.7.4.3
