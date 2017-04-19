From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Apr 2017 22:22:04 +0200
Subject: [PATCH 3/3] ARM: dts: imx7d-nitrogen7: fix rv4162 compatible
In-Reply-To: <20170419202204.7689-1-alexandre.belloni@free-electrons.com>
References: <20170419202204.7689-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170419202204.7689-3-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rv4162 compatbile string is missing the vendor part, add it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx7d-nitrogen7.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 5d98e2b5d54b..a44f992051ac 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -279,7 +279,7 @@
 	status = "okay";
 
 	rtc at 68 {
-		compatible = "rv4162";
+		compatible = "microcrystal,rv4162";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c2_rv4162>;
 		reg = <0x68>;
-- 
2.11.0
