From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 15 Sep 2012 00:23:35 -0600
Subject: [PATCH] MAINTAINERS: add an entry for the BCM2835 ARM sub-architecture
Message-ID: <1347690215-17200-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as the maintainer for the BCM2835 ARM support, and related
drivers. This is mainly so that the MAINTAINERS file contains some
relevant entry, and the rpi/ARM mailing lists; I'd be quite happy if
anyone else came along and wanted to maintain/co-maintain this.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
Vince, can you confirm that the linux-rpi-kernel list is moderated for
non-subscribers?

Note that I cut down the individual to/cc entries when sending this patch,
since otherwise it doesn't get through to the rpi mailing list, and I
wanted to ensure this received coverage there.
---
 MAINTAINERS |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fdc0119..988553e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1613,6 +1613,16 @@ L:	netdev at vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/bnx2x/
 
+BROADCOM BCM2835 ARM ARCHICTURE
+M:	Stephen Warren <swarren@wwwdotorg.org>
+L:	linux-rpi-kernel at lists.infradead.org (moderated for non-subscribers)
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git
+S:	Maintained
+F:	arch/arm/mach-bcm2835/
+F:	arch/arm/boot/dts/bcm2835*
+F:	arch/arm/configs/bcm2835_defconfig
+F:	drivers/*/*bcm2835*
+
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Matt Carlson <mcarlson@broadcom.com>
 M:	Michael Chan <mchan@broadcom.com>
-- 
1.7.9.5
