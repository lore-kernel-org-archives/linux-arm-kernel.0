From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 10 Aug 2013 12:51:50 +0400
Subject: [PATCH 1/2] ARM: dts: i.MX27: Disable AUDMUX in the template
Message-ID: <1376124711-27167-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AUDMUX expects additional parameters to be configured correctly,
so turn it off into a template.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 76cd89f..c037c22 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -300,6 +300,7 @@
 				reg = <0x10016000 0x1000>;
 				clocks = <&clks 0>;
 				clock-names = "audmux";
+				status = "disabled";
 			};
 
 			cspi3: cspi at 10017000 {
-- 
1.8.1.5
