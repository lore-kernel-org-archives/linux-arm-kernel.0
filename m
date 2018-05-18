From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri, 18 May 2018 08:00:53 +0530
Subject: [PATCH 2/5] arm64: dts: actions: Add gpio properties to pinctrl node
 for S900
In-Reply-To: <20180518023056.7869-1-manivannan.sadhasivam@linaro.org>
References: <20180518023056.7869-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180518023056.7869-3-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio properties to pinctrl node for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 0156483f0f4d..05f31a954733 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -178,6 +178,8 @@
 			compatible = "actions,s900-pinctrl";
 			reg = <0x0 0xe01b0000 0x0 0x1000>;
 			clocks = <&cmu CLK_GPIO>;
+			gpio-controller;
+			#gpio-cells = <2>;
 		};
 
 		timer: timer at e0228000 {
-- 
2.14.1
