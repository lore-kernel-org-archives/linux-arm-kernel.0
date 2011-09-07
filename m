From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 7 Sep 2011 09:50:29 +0200
Subject: [PATCH] mtd: drop Integrator flash map Kconfig
Message-ID: <1315381829-21548-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The integrator flash has been deleted, even from the Makefile.
Drop the Kconfig entry as well.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/maps/Kconfig |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index c0c328c..c3d02d4 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -339,10 +339,6 @@ config MTD_SOLUTIONENGINE
 	  This enables access to the flash chips on the Hitachi SolutionEngine and
 	  similar boards. Say 'Y' if you are building a kernel for such a board.
 
-config MTD_ARM_INTEGRATOR
-	tristate "CFI Flash device mapped on ARM Integrator/P720T"
-	depends on ARM && MTD_CFI
-
 config MTD_CDB89712
 	tristate "Cirrus CDB89712 evaluation board mappings"
 	depends on MTD_CFI && ARCH_CDB89712
-- 
1.7.3.2
