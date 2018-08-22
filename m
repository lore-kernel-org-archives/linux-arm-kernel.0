From: jan.tuerk@emtrion.com (Jan Tuerk)
Date: Wed, 22 Aug 2018 17:51:30 +0200
Subject: [PATCH v5 1/4] ARM: dts: imx: Add an cpu0 label for imx6dl devices.
In-Reply-To: <20180427132445.3458-1-jan.tuerk@emtrion.com>
References: <20180427132445.3458-1-jan.tuerk@emtrion.com>
Message-ID: <20180822155137.10018-1-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the label cpu0 allows the adjustment of cpu-parameters
by reference in overlaying dtsi files in the same way as it
is possible for imx6q devices.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index b384913c34dd..105a4c6867e7 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -15,7 +15,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0>;
-- 
2.18.0
