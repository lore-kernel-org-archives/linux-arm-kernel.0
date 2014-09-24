From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 24 Sep 2014 13:20:38 -0500
Subject: [PATCH] ARM: qcom: Update SoC compatibles we support
Message-ID: <1411582838-24159-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move to just using the SoC name in the compatible list so we don't need
to update this for every board going forward.  Also added "qcom,msm8974"
to the list as we support "qcom,apq8074" already (the modemless version
of "qcom,msm8974").

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm/mach-qcom/board.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-qcom/board.c b/arch/arm/mach-qcom/board.c
index 6d8bbf7..e3e44aa 100644
--- a/arch/arm/mach-qcom/board.c
+++ b/arch/arm/mach-qcom/board.c
@@ -16,12 +16,13 @@
 
 static const char * const qcom_dt_match[] __initconst = {
 	"qcom,apq8064",
-	"qcom,apq8074-dragonboard",
+	"qcom,apq8074",
 	"qcom,apq8084",
 	"qcom,ipq8062",
 	"qcom,ipq8064",
-	"qcom,msm8660-surf",
-	"qcom,msm8960-cdp",
+	"qcom,msm8660",
+	"qcom,msm8960",
+	"qcom,msm8974",
 	NULL
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
