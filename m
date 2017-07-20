From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 20 Jul 2017 11:17:12 +0100
Subject: [PATCH v5 02/19] arm64: juno: dts: Use the new coresight replicator
 string
In-Reply-To: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
References: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1500545849-23724-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new compatible for ATB programmable replicator in Juno.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index e8b7413..56f7ac2 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -426,7 +426,7 @@
 	};
 
 	replicator at 20120000 {
-		compatible = "qcom,coresight-replicator1x", "arm,primecell";
+		compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
 		reg = <0 0x20120000 0 0x1000>;
 
 		clocks = <&soc_smc50mhz>;
-- 
2.7.5
