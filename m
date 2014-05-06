From: mporter@linaro.org (Matt Porter)
Date: Tue,  6 May 2014 12:09:45 -0400
Subject: [PATCH] MAINTAINERS: update Broadcom ARM tree location and add an SoC
 family
Message-ID: <1399392585-28183-1-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom ARM tree location has changed names to reflect other SoC
families that are queued here. Also add the 216xx family as maintained.

Signed-off-by: Matt Porter <mporter@linaro.org>
---
arm-soc team: please apply directly for 3.15

 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e67ea24..6031c81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1893,14 +1893,15 @@ L:	netdev at vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/bnx2x/
 
-BROADCOM BCM281XX/BCM11XXX ARM ARCHITECTURE
+BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITECTURE
 M:	Christian Daudt <bcm@fixthebug.org>
 M:	Matt Porter <mporter@linaro.org>
 L:	bcm-kernel-feedback-list at broadcom.com
-T:	git git://git.github.com/broadcom/bcm11351
+T:	git git://github.com/broadcom/mach-bcm
 S:	Maintained
 F:	arch/arm/mach-bcm/
 F:	arch/arm/boot/dts/bcm113*
+F:	arch/arm/boot/dts/bcm216*
 F:	arch/arm/boot/dts/bcm281*
 F:	arch/arm/configs/bcm_defconfig
 F:	drivers/mmc/host/sdhci_bcm_kona.c
-- 
1.8.4
