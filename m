From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 26 Oct 2015 14:25:12 -0700
Subject: [PATCH 3/3] arm: dts: qcom: Update ifc6540 compat for qcom boot format
In-Reply-To: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org>
References: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1445894712-14350-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ifc6540 is an sbc (single board computer) board, so update
the compatible field accordingly.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
index c9c2b769554f..32aaa9d45228 100644
--- a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
+++ b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
@@ -3,7 +3,7 @@
 
 / {
 	model = "Qualcomm APQ8084/IFC6540";
-	compatible = "qcom,apq8084-ifc6540", "qcom,apq8084";
+	compatible = "qcom,apq8084-sbc", "qcom,apq8084";
 
 	aliases {
 		serial0 = &blsp2_uart2;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
