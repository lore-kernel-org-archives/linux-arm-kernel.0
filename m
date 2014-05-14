From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 08:53:23 +0900
Subject: [PATCH] ARM: shmobile: Add DT and defconfigs to MAINTAINERS
Message-ID: <1400111603-20149-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a number of DT and defconfig files which
are maintained as part of shmobile but have not been
listed as such in the MAINTAINERS file. This creates
confusion from time to time.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51ebb77..cded74e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1277,6 +1277,20 @@ W:	http://oss.renesas.com
 Q:	http://patchwork.kernel.org/project/linux-sh/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 S:	Supported
+F:	arch/arm/boot/dts/emev2*
+F:	arch/arm/boot/dts/r7s*
+F:	arch/arm/boot/dts/r8a*
+F:	arch/arm/boot/dts/sh*
+F:	arch/arm/configs/ape6evm_defconfig
+F:	arch/arm/configs/armadillo800eva_defconfig
+F:	arch/arm/configs/bockw_defconfig
+F:	arch/arm/configs/genmai_defconfig
+F:	arch/arm/configs/koelsch_defconfig
+F:	arch/arm/configs/kzm9g_defconfig
+F:	arch/arm/configs/lager_defconfig
+F:	arch/arm/configs/mackerel_defconfig
+F:	arch/arm/configs/marzen_defconfig
+F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/mach-shmobile/
 F:	drivers/sh/
 
-- 
1.8.5.2
