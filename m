From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 14 Jul 2017 14:04:08 +0100
Subject: [PATCH v3 03/18] arm: qcom-msm8974: dts: Update coresight replicator
In-Reply-To: <1500037463-19951-1-git-send-email-suzuki.poulose@arm.com>
References: <1500037463-19951-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1500037463-19951-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the obsolete compatible string for Coresight programmable
replicator with the new one.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: linux-arm-msm at vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 307bf6a..3c7c6b9 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -729,7 +729,7 @@
 		};
 
 		replicator at fc31c000 {
-			compatible = "qcom,coresight-replicator1x", "arm,primecell";
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
 			reg = <0xfc31c000 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
-- 
2.7.5
