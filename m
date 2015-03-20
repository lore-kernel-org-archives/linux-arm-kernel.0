From: linux.amoon@gmail.com (Anand Moon)
Date: Sat, 21 Mar 2015 06:53:51 +1030
Subject: [PATCH] ARM: Exynos5420: dt: Fixed the checkpatch.pl WARNING
 misspelled
Message-ID: <1426883031-3518-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes fixes the misspelled of #interrups-cell.

arch/arm/boot/dts/exynos5420.dtsi:224: WARNING: 'interrups'
	 may be misspelled - perhaps 'interrupts'?

Tested on OdroidXU3 board.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c0e98cf..a78ac1f 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -221,7 +221,7 @@
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x101C0000 0x800>;
 		interrupt-controller;
-		#interrups-cells = <1>;
+		#interrupt-cells = <1>;
 		interrupt-parent = <&mct_map>;
 		interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>,
 				<8>, <9>, <10>, <11>;
-- 
1.9.1
