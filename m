From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Mon, 28 Mar 2016 15:42:43 -0400
Subject: [PATCH] arm: dts: imx6q-ba16: Remove unused vqmmc-supply
Message-ID: <1459194163-8540-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vqmmc supply is not connected to bio supply on the BA16 module.
Remove the same.

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/imx6q-ba16.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index 8f6e603..96701a3 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -390,7 +390,6 @@
 	pinctrl-0 = <&pinctrl_usdhc3 &pinctrl_usdhc3_reset>;
 	bus-width = <8>;
 	vmmc-supply = <&vdd_bperi>;
-	vqmmc-supply = <&vdd_bio>;
 	non-removable;
 	keep-power-in-suspend;
 	status = "okay";
-- 
2.7.4
