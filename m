From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 28 Aug 2014 14:00:43 +0200
Subject: [PATCH] ARM: dts: Sort SHMOBILE dtbs alphabetically
Message-ID: <1409227243-25102-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on Magnus' series "[PATCH 00/05] ARM: shmobile: r8a7740 and
Armadillo cleanup".

 arch/arm/boot/dts/Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2bff594ca7e2..8f9604c6ca24 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -358,24 +358,24 @@ dtb-$(CONFIG_ARCH_S5PV210) += s5pv210-aquila.dtb \
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
-	r8a7791-henninger.dtb \
-	r8a7791-koelsch.dtb \
+	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
-	r8a7779-marzen.dtb
+	r8a7791-henninger.dtb \
+	r8a7791-koelsch.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_sockit.dtb \
-- 
1.9.1
