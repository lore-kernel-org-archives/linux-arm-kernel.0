From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 27 Mar 2018 19:32:45 +0900
Subject: [PATCH 1/2] ARM: dts: uniphier: add pinctrl groups of ethernet for
 second instance
In-Reply-To: <1522146766-14435-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522146766-14435-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1522146766-14435-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl groups of ethernet, such as "ether1_rgmii" and "ether1_rmii".
These are used for second ethernet instance.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index de481c3..c094377 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -33,6 +33,16 @@
 		function = "ether_rmii";
 	};
 
+	pinctrl_ether1_rgmii: ether1-rgmii {
+		groups = "ether1_rgmii";
+		function = "ether1_rgmii";
+	};
+
+	pinctrl_ether1_rmii: ether1-rmii {
+		groups = "ether1_rmii";
+		function = "ether1_rmii";
+	};
+
 	pinctrl_i2c0: i2c0 {
 		groups = "i2c0";
 		function = "i2c0";
-- 
2.7.4
