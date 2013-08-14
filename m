From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 14 Aug 2013 13:05:52 +0400
Subject: [PATCH 2/3] ARM: dts: i.MX51: Add one more I2C2 pinmux entry
In-Reply-To: <1376471153-3452-1-git-send-email-shc_work@mail.ru>
References: <1376471153-3452-1-git-send-email-shc_work@mail.ru>
Message-ID: <1376471153-3452-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds one more I2C2 alternate pinmux entry.
GPIO1_2 <=> SCL
GPIO1_3 <=> SDA

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 6d8f94a..a85abb4 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -622,6 +622,13 @@
 				MX51_PAD_EIM_D24__I2C2_SDA 0x400001ed
 			>;
 		};
+
+		pinctrl_i2c2_3: i2c2grp-3 {
+			fsl,pins = <
+				MX51_PAD_GPIO1_2__I2C2_SCL 0x400001ed
+				MX51_PAD_GPIO1_3__I2C2_SDA 0x400001ed
+			>;
+		};
 	};
 
 	ipu_disp1 {
-- 
1.8.1.5
