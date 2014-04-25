From: agross@codeaurora.org (Andy Gross)
Date: Fri, 25 Apr 2014 15:41:55 -0500
Subject: [PATCH] pinctrl: qcom: Correct name for pin 0
Message-ID: <1398458515-15654-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix copy/paste error in pinctrl_pin_desc for pin 0.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 drivers/pinctrl/pinctrl-ipq8064.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ipq8064.c b/drivers/pinctrl/pinctrl-ipq8064.c
index 1700b49..54aba9f 100644
--- a/drivers/pinctrl/pinctrl-ipq8064.c
+++ b/drivers/pinctrl/pinctrl-ipq8064.c
@@ -20,7 +20,7 @@
 #include "pinctrl-msm.h"
 
 static const struct pinctrl_pin_desc ipq8064_pins[] = {
-	PINCTRL_PIN(0, "GPIO_1"),
+	PINCTRL_PIN(0, "GPIO_0"),
 	PINCTRL_PIN(1, "GPIO_1"),
 	PINCTRL_PIN(2, "GPIO_2"),
 	PINCTRL_PIN(3, "GPIO_3"),
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
