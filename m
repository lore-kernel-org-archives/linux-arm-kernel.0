From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Dec 2012 23:08:19 +0100
Subject: [PATCH 4/6] ARM: sunxi: Add uart1 pinctrl groups
In-Reply-To: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1355177301-31928-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index ad42aec..0fc238d 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -23,5 +23,19 @@
 		reg = <0x01c20800 0x400>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		uart1_pins_a: uart1 at 0 {
+			reg = <0>;
+			allwinner,pin-ids = <0x40a4 0x40b4>;
+			allwinner,drive = <0>;
+			allwinner,pull = <0>;
+		};
+
+		uart1_pins_b: uart1 at 1 {
+			reg = <1>;
+			allwinner,pin-ids = <0x6034 0x6044>;
+			allwinner,drive = <0>;
+			allwinner,pull = <0>;
+		};
 	};
 };
-- 
1.7.9.5
