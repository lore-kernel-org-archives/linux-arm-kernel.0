From: csd@broadcom.com (Christian Daudt)
Date: Fri, 20 Sep 2013 15:33:11 -0700
Subject: [PATCH] MAINTAINERS: Update mach-bcm related email address
Message-ID: <1379716391-11263-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update email address on mach-bcm + drivers for Broadcom
mobile SoCs.

Signed-off-by: Christian Daudt <csd@broadcom.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index e61c2e8..b2f857c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1812,7 +1812,8 @@ S:	Supported
 F:	drivers/net/ethernet/broadcom/bnx2x/
 
 BROADCOM BCM281XX/BCM11XXX ARM ARCHITECTURE
-M:	Christian Daudt <csd@broadcom.com>
+M:	Christian Daudt <bcm@fixthebug.org>
+L:	bcm-kernel-feedback-list at broadcom.com
 T:	git git://git.github.com/broadcom/bcm11351
 S:	Maintained
 F:	arch/arm/mach-bcm/
-- 
1.7.10.4
