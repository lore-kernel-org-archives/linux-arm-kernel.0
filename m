From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:07 +0900
Subject: [PATCH 01/19] ARM: dts: Sort SHMOBILE dtbs alphabetically
In-Reply-To: <cover.1414556943.git.horms+renesas@verge.net.au>
References: <cover.1414556943.git.horms+renesas@verge.net.au>
Message-ID: <c9095970ceb8f46ede77d1de7ed0275099e55d2a.1414556943.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[horms+renesas at verge.net.au:  update for addition of r8a7794-alt.dtb]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 38c89ca..88282c8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -377,24 +377,24 @@ dtb-$(CONFIG_ARCH_S5PV210) += s5pv210-aquila.dtb \
 	s5pv210-smdkv210.dtb \
 	s5pv210-torbreck.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += r7s72100-genmai.dtb \
+	r8a73a4-ape6evm.dtb \
+	r8a73a4-ape6evm-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
 	r8a7779-marzen.dtb \
-	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb \
+	r8a7791-koelsch.dtb \
+	sh7372-mackerel.dtb \
 	sh73a0-kzm9g.dtb \
-	sh73a0-kzm9g-reference.dtb \
-	r8a73a4-ape6evm.dtb \
-	r8a73a4-ape6evm-reference.dtb \
-	sh7372-mackerel.dtb
+	sh73a0-kzm9g-reference.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
 	r8a7740-armadillo800eva.dtb \
+	r8a7779-marzen.dtb \
+	r8a7790-lager.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
-	r8a7790-lager.dtb \
-	r8a7779-marzen.dtb \
 	r8a7794-alt.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
-- 
2.1.1
