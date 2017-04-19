From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Apr 2017 22:22:03 +0200
Subject: [PATCH 2/3] ARM: dts: imx6qdl-nitrogen6_som2: fix rv4162 compatible
In-Reply-To: <20170419202204.7689-1-alexandre.belloni@free-electrons.com>
References: <20170419202204.7689-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170419202204.7689-2-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rv4162 vendor is microcrystal, not ST.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
index 559da17297ef..aeaa5a6e4fcf 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
@@ -326,7 +326,7 @@
 	};
 
 	rtc at 68 {
-		compatible = "st,rv4162";
+		compatible = "microcrystal,rv4162";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rv4162>;
 		reg = <0x68>;
-- 
2.11.0
