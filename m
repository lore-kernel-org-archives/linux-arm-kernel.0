From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  3 Apr 2017 12:08:09 +0200
Subject: [PATCH 3/3] arm64: dts: r8a7795: salvator-x: Drop _clk suffix from
 X12 clock node name
In-Reply-To: <1491214089-14093-1-git-send-email-geert+renesas@glider.be>
References: <1491214089-14093-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1491214089-14093-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current practice is to not add _clk suffixes to clock node names in
DT, as these names are used as the actual clock names.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index f25241921067dcef..639aa085d9966676 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -56,7 +56,7 @@
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
 
-	x12_clk: x12_clk {
+	x12_clk: x12 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24576000>;
-- 
2.7.4
