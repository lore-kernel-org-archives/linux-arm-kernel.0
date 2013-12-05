From: sw@weilnetz.de (Stefan Weil)
Date: Thu,  5 Dec 2013 20:17:40 +0100
Subject: [PATCH] ARM: bcm2835: Fix grammar in help message
Message-ID: <1386271060-2375-1-git-send-email-sw@weilnetz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace "is use" by "is used" and remove a comma.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jiri Kosina <trivial@kernel.org>
Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 arch/arm/mach-bcm2835/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm2835/Kconfig b/arch/arm/mach-bcm2835/Kconfig
index 560045c..d1f9612 100644
--- a/arch/arm/mach-bcm2835/Kconfig
+++ b/arch/arm/mach-bcm2835/Kconfig
@@ -12,4 +12,4 @@ config ARCH_BCM2835
 	select PINCTRL_BCM2835
 	help
 	  This enables support for the Broadcom BCM2835 SoC. This SoC is
-	  use in the Raspberry Pi, and Roku 2 devices.
+	  used in the Raspberry Pi and Roku 2 devices.
-- 
1.7.10.4
