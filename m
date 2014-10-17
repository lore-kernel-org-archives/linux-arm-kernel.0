From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 Oct 2014 21:57:16 -0600
Subject: [PATCH] MAINTAINERS: corrected bcm2835 search
Message-ID: <1413518236-22893-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Scott Branden <sbranden@broadcom.com>

Corrected bcm2835 maintainer info by using N: to specify any files with
bcm2835 in are directed to the proper maintainer.
Also corrected minor mispelling of ARCHITECTURE in 2 comment locations.

Signed-off-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 MAINTAINERS | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0eb6c2a..5eb534b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2062,17 +2062,14 @@ F:	arch/arm/configs/bcm_defconfig
 F:	drivers/mmc/host/sdhci-bcm-kona.c
 F:	drivers/clocksource/bcm_kona_timer.c
 
-BROADCOM BCM2835 ARM ARCHICTURE
+BROADCOM BCM2835 ARM ARCHITECTURE
 M:	Stephen Warren <swarren@wwwdotorg.org>
 L:	linux-rpi-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git
 S:	Maintained
-F:	arch/arm/mach-bcm/board_bcm2835.c
-F:	arch/arm/boot/dts/bcm2835*
-F:	arch/arm/configs/bcm2835_defconfig
-F:	drivers/*/*bcm2835*
+N:	bcm2835
 
-BROADCOM BCM5301X ARM ARCHICTURE
+BROADCOM BCM5301X ARM ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	linux-arm-kernel at lists.infradead.org
 S:	Maintained
-- 
1.9.1
