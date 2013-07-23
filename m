From: csd@broadcom.com (Christian Daudt)
Date: Tue, 23 Jul 2013 16:57:10 -0700
Subject: [PATCH] MAINTAINERS: Add mach-bcm and drivers
Message-ID: <1374623830-32105-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding ownership to maintainers file for the mach-bcm related files,
including drivers that are used for the SoCs defined in mach-bcm.

Signed-off-by: Christian Daudt <csd@broadcom.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index bf61e04..49480494 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1785,6 +1785,17 @@ L:	netdev at vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/bnx2x/
 
+BROADCOM BCM281XX/BCM11XXX ARM ARCHITECTURE
+M:	Christian Daudt <csd@broadcom.com>
+T:	git git://git.github.com/broadcom/bcm11351
+S:	Maintained
+F:	arch/arm/mach-bcm/
+F:	arch/arm/boot/dts/bcm113*
+F:	arch/arm/boot/dts/bcm281*
+F:	arch/arm/configs/bcm_defconfig
+F:	drivers/mmc/host/sdhci_bcm_kona.c
+F:	drivers/clocksource/bcm_kona_timer.c
+
 BROADCOM BCM2835 ARM ARCHICTURE
 M:	Stephen Warren <swarren@wwwdotorg.org>
 L:	linux-rpi-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.7.10.4
