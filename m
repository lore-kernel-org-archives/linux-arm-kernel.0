From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:48 +0900
Subject: [PATCH 3/6] ARM: shmobile: armadillo800eva: Build DTS for
 multiplatform
In-Reply-To: <cover.1409792648.git.horms+renesas@verge.net.au>
References: <cover.1409792648.git.horms+renesas@verge.net.au>
Message-ID: <cc9517d52fbf4b6e8baf0254f90b47bc1a5d90bb.1409792648.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Build the r8a7740 Armadillo800EVA board DTB in case
of Multiplatform. The DT reference case will be removed
and can be ignored for now.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..e389b40 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -372,6 +372,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += r7s72100-genmai.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
+	r8a7740-armadillo800eva.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb \
-- 
2.0.1
