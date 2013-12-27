From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Dec 2013 19:43:09 -0700
Subject: [PATCH 1/3] ARM: bcm2835: Fix grammar in help message
Message-ID: <1388112192-4762-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Weil <sw@weilnetz.de>

Replace "is use" by "is used" and remove a comma.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
Since I only have 3 patches for bcm2835 this kernel cycle, and they'll
likely go into different branches, I'm just re-sending them for direct
application. These patches are already in linux-next, but since there
are no linux-next being built at the moment, I've reset bcm2835's
for-next to remove them, so there will be no conflict.

I imagine this would go into a "soc" branch in arm-soc.

 arch/arm/mach-bcm2835/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm2835/Kconfig b/arch/arm/mach-bcm2835/Kconfig
index 560045ca..d1f9612 100644
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
