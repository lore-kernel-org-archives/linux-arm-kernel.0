From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 26 Oct 2015 14:25:11 -0700
Subject: [PATCH 2/3] arm64: dts: qcom: Make msm8916-mtp compatible string
 compliant
In-Reply-To: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org>
References: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1445894712-14350-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This compatible string isn't compliant with the format for
subtypes. Replace it with a compliant compatible type.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
index fced77f0fd3a..b0a064d3806b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
@@ -17,6 +17,6 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM 8916 MTP";
-	compatible = "qcom,msm8916-mtp", "qcom,msm8916-mtp-smb1360",
+	compatible = "qcom,msm8916-mtp", "qcom,msm8916-mtp/1",
 			"qcom,msm8916", "qcom,mtp";
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
