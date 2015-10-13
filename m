From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Tue, 13 Oct 2015 13:43:55 +0200
Subject: [PATCH] ARM: dts: imx6: phyFLEX: fix typo in "pinctrl-names"
Message-ID: <1444736635-19893-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a typo, replacing "pinctrl-name" by "pinctrl-names"
in the Phytec phyFLEX-i.MX6 Quad dtsi.

Also fix a typo in the board name

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 9e6ecd99b472..24bdff26b483 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -12,7 +12,7 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Phytec phyFLEX-i.MX6 Ouad";
+	model = "Phytec phyFLEX-i.MX6 Quad";
 	compatible = "phytec,imx6q-pfla02", "fsl,imx6q";
 
 	memory {
@@ -373,7 +373,7 @@
 };
 
 &pcie {
-	pinctrl-name = "default";
+	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio4 17 0>;
 	status = "disabled";
-- 
2.1.4
