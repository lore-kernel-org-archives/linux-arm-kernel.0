From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Fri, 13 Feb 2015 15:12:03 +0100
Subject: [PATCH 3/5] ARM: dts: imx28-apf28dev: fix mac1 gpio location and
 polarity
In-Reply-To: <1423836725-86061-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1423836725-86061-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1423836725-86061-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1423836725-86061-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
Signed-off-by: Sebastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/imx28-apf28dev.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 86e8d81..68405c3 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -157,7 +157,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac1_pins_a>;
-			phy-reset-gpios = <&gpio0 23 0>;
+			phy-reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
 			status = "okay";
 		};
 	};
-- 
2.0.5
