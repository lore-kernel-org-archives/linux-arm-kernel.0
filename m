From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 22 Sep 2011 14:16:26 +0200
Subject: [PATCH 1/2] ARM: mach-ux500: enable fix for ARM errata 754322
Message-ID: <1316693786-18623-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

This applies ARM errata fix 754322 for all ux500 platforms.

Cc: stable at kernel.org
Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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
1.7.3.2
