From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2018 15:43:12 +0200
Subject: [PATCH] ARM: dts: Fix the RPM clock controller compatible string
Message-ID: <20180418134312.19314-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The right string is msm8660 and there is also apq8060, but not
apq8660, so fix this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 33030f9419fe..70698941f64c 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -452,7 +452,7 @@
 			clock-names = "ram";
 
 			rpmcc: clock-controller {
-				compatible	= "qcom,rpmcc-apq8660", "qcom,rpmcc";
+				compatible	= "qcom,rpmcc-msm8660", "qcom,rpmcc";
 				#clock-cells = <1>;
 			};
 
-- 
2.14.3
