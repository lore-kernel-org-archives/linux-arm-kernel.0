From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 17 Nov 2015 17:15:27 +0530
Subject: [PATCH V5 6/6] dts: msm8974: Add dma channels for blsp2_i2c1 node
In-Reply-To: <1447760727-4897-1-git-send-email-sricharan@codeaurora.org>
References: <1447760727-4897-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1447760727-4897-7-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 7786408..bd1be53 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -328,6 +328,8 @@
 			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			dmas = <&blsp2_dma 20>, <&blsp2_dma 21>;
+			dma-names = "tx", "rx";
 		};
 
 		spmi_bus: spmi at fc4cf000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
