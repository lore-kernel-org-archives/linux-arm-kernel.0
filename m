From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 18 May 2018 13:49:16 +0530
Subject: [PATCH V7 03/12] ARM: dts: ipq4019: Change the max opp frequency
In-Reply-To: <1526631565-9972-1-git-send-email-sricharan@codeaurora.org>
References: <1526631565-9972-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1526631565-9972-4-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The max opp frequency is 716MHZ. So update that.

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 1541e18..2c4ad7d 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -47,7 +47,7 @@
 				48000	1100000
 				200000	1100000
 				500000	1100000
-				666000	1100000
+				716000  1100000
 			>;
 			clock-latency = <256000>;
 		};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
