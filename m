From: srinidhi.kasagar@stericsson.com (Srinidhi KASAGAR)
Date: Mon, 11 Oct 2010 14:33:33 +0530
Subject: [PATCH] ux500: The platform is not just based on early drop silicon
	version.
Message-ID: <1286787813-31381-1-git-send-email-srinidhi.kasagar@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update Kconfig text accordingly.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/Kconfig |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 6625e5b..b48cd4e 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -21,9 +21,7 @@ config MACH_U8500_MOP
 	bool "U8500 Development platform"
 	select UX500_SOC_DB8500
 	help
-	  Include support for mop500 development platform
-	  based on U8500 architecture. The platform is based
-	  on early drop silicon version of 8500.
+	  Include support for the mop500 development platform.
 
 config MACH_U5500
 	bool "U5500 Development platform"
-- 
1.6.3.3
