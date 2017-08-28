From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon, 28 Aug 2017 11:11:45 +0900
Subject: [PATCH] ARM: dts: uniphier: add pinctrl groups of ethernet phy mode
Message-ID: <1503886305-29815-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl groups of ethenet phy mode, such as "ether_rgmii", "ether_rmii",
and "ether_mii".

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index 425b8f1..be82cdd 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -18,6 +18,21 @@
 		function = "emmc";
 	};
 
+	pinctrl_ether_mii: ether_mii_grp {
+		groups = "ether_mii";
+		function = "ether_mii";
+	};
+
+	pinctrl_ether_rgmii: ether_rgmii_grp {
+		groups = "ether_rgmii";
+		function = "ether_rgmii";
+	};
+
+	pinctrl_ether_rmii: ether_rmii_grp {
+		groups = "ether_rmii";
+		function = "ether_rmii";
+	};
+
 	pinctrl_i2c0: i2c0_grp {
 		groups = "i2c0";
 		function = "i2c0";
-- 
2.7.4
