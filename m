From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Fri, 13 Feb 2015 15:12:02 +0100
Subject: [PATCH 2/5] ARM: dts: imx28-apf28: fix mac0 gpio polarity
In-Reply-To: <1423836725-86061-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1423836725-86061-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1423836725-86061-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
Signed-off-by: Sebastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/imx28-apf28.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-apf28.dts b/arch/arm/boot/dts/imx28-apf28.dts
index 7198fe3..070e59c 100644
--- a/arch/arm/boot/dts/imx28-apf28.dts
+++ b/arch/arm/boot/dts/imx28-apf28.dts
@@ -78,7 +78,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
 			status = "okay";
 		};
 	};
-- 
2.0.5
