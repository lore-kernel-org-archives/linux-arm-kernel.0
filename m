From: vishnupatekar0510@gmail.com (VishnuPatekar)
Date: Fri, 12 Dec 2014 23:55:47 +0530
Subject: [PATCHv3 4/5] ARM: sunxi: dts: Add A10/A20 PS2 pin muxing options
In-Reply-To: <1418408748-9797-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1418408748-9797-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1418408748-9797-5-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added the pinmuxing options for Allwinner A10 and A20.

Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |   14 ++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi |   14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ef9a01c..5a29039 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -630,6 +630,20 @@
 				allwinner,pull = <0>;
 			};
 
+			ps20_pins_a: ps20 at 0 {
+				    allwinner,pins = "PI20", "PI21";
+				    allwinner,function = "ps2";
+				    allwinner,drive = <0>;
+				    allwinner,pull = <0>;
+			};
+
+			ps21_pins_a: ps21 at 0 {
+				    allwinner,pins = "PH12", "PH13";
+				    allwinner,function = "ps2";
+				    allwinner,drive = <0>;
+				    allwinner,pull = <0>;
+			};
+
 		};
 
 		timer at 01c20c00 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 6ab7714..247def0 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -867,6 +867,20 @@
 				    allwinner,pull = <0>;
 			};
 
+			ps20_pins_a: ps20 at 0 {
+				    allwinner,pins = "PI20", "PI21";
+				    allwinner,function = "ps2";
+				    allwinner,drive = <0>;
+				    allwinner,pull = <0>;
+			};
+
+			ps21_pins_a: ps21 at 0 {
+				    allwinner,pins = "PH12", "PH13";
+				    allwinner,function = "ps2";
+				    allwinner,drive = <0>;
+				    allwinner,pull = <0>;
+			};
+
 		};
 
 		timer at 01c20c00 {
-- 
1.7.9.5
