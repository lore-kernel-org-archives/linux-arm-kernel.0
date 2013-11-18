From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Nov 2013 15:52:02 +0100
Subject: [PATCH] ARM: cfa10036: Add dr_mode and phy_type properties to the DT
Message-ID: <1384786322-17168-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This USB port is only used as peripheral. Set it accordingly in its DT
node.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10036.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index 1ec8c94bbac9..94e73e2cd4f8 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -101,6 +101,8 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&usb0_otg_cfa10036>;
 			status = "okay";
+			dr_mode = "peripheral";
+			phy_type = "utmi";
 		};
 	};
 
-- 
1.8.4.2
