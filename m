From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Apr 2017 22:22:02 +0200
Subject: [PATCH 1/3] ARM: dts: imx6qdl-nitrogen6_max: fix rv4162 compatible
Message-ID: <20170419202204.7689-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rv4162 vendor is microcrystal, not ST.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index bad3c9f9eeac..b63134e3b51a 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -408,7 +408,7 @@
 	};
 
 	rtc: rtc at 68 {
-		compatible = "st,rv4162";
+		compatible = "microcrystal,rv4162";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rv4162>;
 		reg = <0x68>;
-- 
2.11.0
