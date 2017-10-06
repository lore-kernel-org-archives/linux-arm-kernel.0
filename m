From: ctatlor97@gmail.com (Craig Tatlor)
Date: Fri,  6 Oct 2017 16:57:51 +0100
Subject: [PATCH] arm64: dts: qcom: msm8916: Shrink mdp address length for
 msm8916
Message-ID: <20171006155751.31261-1-ctatlor97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This shrinks the address size down to 89000 from its previous 90000
which was mistakenly pulled from downstream.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index dc3817593e14..47262757b09e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -814,7 +814,7 @@
 
 			mdp: mdp at 1a01000 {
 				compatible = "qcom,mdp5";
-				reg = <0x1a01000 0x90000>;
+				reg = <0x1a01000 0x89000>;
 				reg-names = "mdp_phys";
 
 				interrupt-parent = <&mdss>;
-- 
2.14.1
