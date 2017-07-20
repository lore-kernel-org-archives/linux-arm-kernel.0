From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 20 Jul 2017 11:17:14 +0100
Subject: [PATCH v5 04/19] arm64: qcom-msm8916: dts: Update coresight replicator
In-Reply-To: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
References: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1500545849-23724-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the obsolete compatible string for Coresight programmable
replicator with the new one.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: linux-arm-msm at vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 039991f..3d43f4d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -990,7 +990,7 @@
 		};
 
 		replicator at 824000 {
-			compatible = "qcom,coresight-replicator1x", "arm,primecell";
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
 			reg = <0x824000 0x1000>;
 
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-- 
2.7.5
