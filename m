From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  6 Jul 2018 10:32:47 +0200
Subject: [PATCH v5 2/4] arm64: dts: lg1313: DT fix
 s/#interrupts-cells/#interrupt-cells/
In-Reply-To: <20180706083249.25399-1-geert+renesas@glider.be>
References: <20180706083249.25399-1-geert+renesas@glider.be>
Message-ID: <20180706083249.25399-3-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Chanho Min <chanho.min@lge.com>
---
v3:
  - Add Acked-by,

v2:
  - New.
---
 arch/arm64/boot/dts/lg/lg1313.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index 1887af654a7db966..fb1f5252977da967 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -124,7 +124,7 @@
 	amba {
 		#address-cells = <2>;
 		#size-cells = <1>;
-		#interrupts-cells = <3>;
+		#interrupt-cells = <3>;
 
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
-- 
2.17.1
