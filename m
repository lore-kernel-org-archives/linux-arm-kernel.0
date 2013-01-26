From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 26 Jan 2013 15:36:54 +0100
Subject: [PATCH 4/5] ARM: sunxi: Add the sun4i pinctrl and gpio nodes
In-Reply-To: <1359211016-24097-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1359211016-24097-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1359211016-24097-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index e61fdd4..73e0dd5 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -16,4 +16,13 @@
 	memory {
 		reg = <0x40000000 0x80000000>;
 	};
+
+	soc {
+		pinctrl at 01c20800 {
+			compatible = "allwinner,sun4i-a10-pinctrl";
+			reg = <0x01c20800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
 };
-- 
1.7.10.4
