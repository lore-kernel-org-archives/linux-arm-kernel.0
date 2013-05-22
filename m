From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 15:22:59 +0100
Subject: [PATCH 5/7] pinctrl/nomadik: Standardise Pinctrl compat string for
 Nomadik based platforms
In-Reply-To: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
References: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1369232581-18923-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 3428175..7712d93 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -2104,7 +2104,7 @@ static struct pinctrl_desc nmk_pinctrl_desc = {
 
 static const struct of_device_id nmk_pinctrl_match[] = {
 	{
-		.compatible = "stericsson,nmk-pinctrl-stn8815",
+		.compatible = "stericsson,stn8815-pinctrl",
 		.data = (void *)PINCTRL_NMK_STN8815,
 	},
 	{
-- 
1.7.10.4
