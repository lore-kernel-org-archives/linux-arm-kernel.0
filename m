From: jason.hui.liu@nxp.com (Jason Liu)
Date: Sat, 22 Oct 2016 22:57:09 +0800
Subject: [PATCH 1/1] arm: dts: imx6ul: 14x14-evk: add the optee node
Message-ID: <1477148229-6940-1-git-send-email-jason.hui.liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the optee node for the i.MX6UL 14x14 evk board

Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index e281d50..e68dc19 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -30,6 +30,13 @@
 		status = "okay";
 	};
 
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.9.1
