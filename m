From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 15:23:00 +0100
Subject: [PATCH 6/7] pinctrl/nomadik: Standardise Pinctrl compat string for
 DBx5x based platforms
In-Reply-To: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
References: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1369232581-18923-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 7712d93..8a4f9c5 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -2108,11 +2108,11 @@ static const struct of_device_id nmk_pinctrl_match[] = {
 		.data = (void *)PINCTRL_NMK_STN8815,
 	},
 	{
-		.compatible = "stericsson,nmk-pinctrl",
+		.compatible = "stericsson,db8500-pinctrl",
 		.data = (void *)PINCTRL_NMK_DB8500,
 	},
 	{
-		.compatible = "stericsson,nmk-pinctrl-db8540",
+		.compatible = "stericsson,db8540-pinctrl",
 		.data = (void *)PINCTRL_NMK_DB8540,
 	},
 	{},
-- 
1.7.10.4
