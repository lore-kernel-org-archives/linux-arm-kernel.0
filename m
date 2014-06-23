From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:28 +0900
Subject: [PATCH] ARM: shmobile: Add DT and defconfigs to MAINTAINERS
In-Reply-To: <cover.1403487346.git.horms+renesas@verge.net.au>
References: <cover.1403487346.git.horms+renesas@verge.net.au>
Message-ID: <0b514fdb52073e348ade842355f37f6976768e44.1403487346.git.horms+renesas@verge.net.au>
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
index 134483f..32e8a20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1296,6 +1296,20 @@ W:	http://oss.renesas.com
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
2.0.0.rc2
