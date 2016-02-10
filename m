From: lars.persson@axis.com (Lars Persson)
Date: Wed, 10 Feb 2016 13:41:50 +0100
Subject: [PATCH 1/8] clk: add device tree binding for artpec-6 pll1 clock
In-Reply-To: <cover.1455107681.git.larper@axis.com>
References: <cover.1455107681.git.larper@axis.com>
Message-ID: <c092f501a595032f9b76f18fc4bf093503a181c8.1455107681.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lars Persson <larper@axis.com>
---
 Documentation/devicetree/bindings/clock/artpec6.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/artpec6.txt

diff --git a/Documentation/devicetree/bindings/clock/artpec6.txt b/Documentation/devicetree/bindings/clock/artpec6.txt
new file mode 100644
index 0000000..e50f7a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/artpec6.txt
@@ -0,0 +1,14 @@
+* Clock bindings for Axis ARTPEC-6 chip
+
+Required properties:
+- compatible: Should be "axis,artpec6-pll1-clock"
+- #clock-cells: Should be <1>
+
+Examples:
+
+pll1_clk: pll1_clk {
+	#clock-cells = <1>;
+	compatible = "axis,artpec6-pll1-clock";
+	clocks = <&ext_clk>;
+	status = "okay";
+};
-- 
2.1.4
