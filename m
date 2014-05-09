From: galak@codeaurora.org (Kumar Gala)
Date: Fri,  9 May 2014 13:08:25 -0500
Subject: [PATCH] pinctrl: qcom: ipq8064: Fix naming convention
Message-ID: <1399658905-12415-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop underscore in spdif_groups to match all other groups.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 drivers/pinctrl/pinctrl-ipq8064.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ipq8064.c b/drivers/pinctrl/pinctrl-ipq8064.c
index 54aba9f..acafea4 100644
--- a/drivers/pinctrl/pinctrl-ipq8064.c
+++ b/drivers/pinctrl/pinctrl-ipq8064.c
@@ -366,7 +366,7 @@ static const char * const sdc1_groups[] = {
 };
 
 static const char * const spdif_groups[] = {
-	"gpio_10", "gpio_48",
+	"gpio10", "gpio48",
 };
 
 static const char * const nand_groups[] = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
