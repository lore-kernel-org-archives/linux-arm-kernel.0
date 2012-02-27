From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Feb 2012 17:23:25 +0800
Subject: [PATCH 2/2] ARM: dts: imx6q-sabrelite: add vmmc-supply for usdhc
In-Reply-To: <1330334605-568-1-git-send-email-shawn.guo@linaro.org>
References: <1330334605-568-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330334605-568-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 3a9d32c..4663a4e 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -32,12 +32,14 @@
 			usdhc at 02198000 { /* uSDHC3 */
 				cd-gpios = <&gpio7 0 0>;
 				wp-gpios = <&gpio7 1 0>;
+				vmmc-supply = <&reg_3p3v>;
 				status = "okay";
 			};
 
 			usdhc at 0219c000 { /* uSDHC4 */
 				cd-gpios = <&gpio2 6 0>;
 				wp-gpios = <&gpio2 7 0>;
+				vmmc-supply = <&reg_3p3v>;
 				status = "okay";
 			};
 
-- 
1.7.5.4
