From: sricharan@codeaurora.org (Sricharan R)
Date: Tue,  7 Apr 2015 00:01:07 +0530
Subject: [PATCH V2 6/6] dts: msm8974: Add dma channels for blsp2_i2c1 node
In-Reply-To: <1428345067-21878-1-git-send-email-sricharan@codeaurora.org>
References: <1428345067-21878-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1428345067-21878-7-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 [v2] Changed dma channel names as per comments.

 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index c2e8711..5cb0772 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -246,6 +246,8 @@
 			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			dmas = <&blsp2_dma 20>, <&blsp2_dma 21>;
+			dma-names = "tx", "rx";
 		};
 
 		spmi_bus: spmi at fc4cf000 {
-- 
1.8.2.1
