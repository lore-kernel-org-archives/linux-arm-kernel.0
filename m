From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Fri, 16 Jun 2017 12:34:37 +0530
Subject: [PATCH v4 1/4] ARM: dts: imx6ul-geam-kit: Remove re-enabled usdhc1
Message-ID: <1497596680-3186-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

usdhc1 is enabled and assigned pinctrl-0 on imx6ul-geam.dtsi
but same thing done on imx6ul-geam-kit.dts, so remove this
re-enabled node from the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- New patch

 arch/arm/boot/dts/imx6ul-geam-kit.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-geam-kit.dts b/arch/arm/boot/dts/imx6ul-geam-kit.dts
index 142e60c..40de2d7 100644
--- a/arch/arm/boot/dts/imx6ul-geam-kit.dts
+++ b/arch/arm/boot/dts/imx6ul-geam-kit.dts
@@ -88,12 +88,6 @@
 	};
 };
 
-&usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	status = "okay";
-};
-
 &tsc {
 	measure-delay-time = <0x1ffff>;
 	pre-charge-time = <0x1fff>;
-- 
2.7.4
