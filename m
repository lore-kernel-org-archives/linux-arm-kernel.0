From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Dec 2012 21:18:12 +0100
Subject: [PATCH 3/6] ARM: sunxi: Add pinctrl node to the device tree
In-Reply-To: <1355948295-19680-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1355948295-19680-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1355948295-19680-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 59a2d26..e29c52b 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -17,4 +17,11 @@
 	memory {
 		reg = <0x40000000 0x20000000>;
 	};
+
+	pinctrl at 01c20800 {
+		compatible = "allwinner,sun5i-a13-pinctrl";
+		reg = <0x01c20800 0x400>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
 };
-- 
1.7.9.5
