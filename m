From: embed3d@gmail.com (Philipp Rossak)
Date: Mon, 29 Jan 2018 00:29:15 +0100
Subject: [PATCH v2 12/16] arm: dts: sun8i: h3: add support for the thermal
 sensor in H3
In-Reply-To: <20180128232919.12639-1-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
Message-ID: <20180128232919.12639-13-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing compatible and the thermal sensor cells.
The H3 has one sensor.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 8495deecedad..fbb007e5798e 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -128,3 +128,8 @@
 &pio {
 	compatible = "allwinner,sun8i-h3-pinctrl";
 };
+
+&ths {
+	compatible = "allwinner,sun8i-h3-ths";
+	#thermal-sensor-cells = <0>;
+};
-- 
2.11.0
