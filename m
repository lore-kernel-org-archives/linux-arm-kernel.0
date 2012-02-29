From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 29 Feb 2012 18:03:24 +0100
Subject: [PATCH] ARM: ux500: delete TPS6105X selection
Message-ID: <1330535004-4454-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Having this driver selected here only cause problems, get it
out of there and selected it from menuconfig or wherever
instead. Mea culpa.

Cc: Mathieu Poirer <mathieu.poirier@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 94d80a4..d008812 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -25,7 +25,6 @@ menu "Ux500 target platform (boards)"
 config MACH_U8500
 	bool "U8500 Development platform"
 	select UX500_SOC_DB8500
-	select TPS6105X
 	help
 	  Include support for the mop500 development platform.
 
-- 
1.7.8
