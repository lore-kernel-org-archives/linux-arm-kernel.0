From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Thu, 19 Jul 2018 15:23:27 +0900
Subject: [PATCH 1/3] ARM: dts: uniphier: add SPI pin-mux node
In-Reply-To: <1531981409-28396-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1531981409-28396-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <1531981409-28396-2-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

This commit adds pin-mux nodes for SPI controller.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index 51f0e69..5dc4cf7 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -126,6 +126,26 @@
 		function = "sd1";
 	};
 
+	pinctrl_spi0: spi0 {
+		groups = "spi0";
+		function = "spi0";
+	};
+
+	pinctrl_spi1: spi1 {
+		groups = "spi1";
+		function = "spi1";
+	};
+
+	pinctrl_spi2: spi2 {
+		groups = "spi2";
+		function = "spi2";
+	};
+
+	pinctrl_spi3: spi3 {
+		groups = "spi3";
+		function = "spi3";
+	};
+
 	pinctrl_system_bus: system-bus {
 		groups = "system_bus", "system_bus_cs1";
 		function = "system_bus";
-- 
2.7.4
