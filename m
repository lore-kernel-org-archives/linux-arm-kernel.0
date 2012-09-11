From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 16:20:04 +0200
Subject: [PATCH 2/2] pinctrl: mvebu: remove dead code
In-Reply-To: <1347373204-17883-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347373204-17883-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347373204-17883-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pinctrl/pinctrl-mvebu.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mvebu.c b/drivers/pinctrl/pinctrl-mvebu.c
index ed1fc3b..720e547 100644
--- a/drivers/pinctrl/pinctrl-mvebu.c
+++ b/drivers/pinctrl/pinctrl-mvebu.c
@@ -128,19 +128,6 @@ static struct mvebu_mpp_ctrl_setting *mvebu_pinctrl_find_gpio_setting(
 	return NULL;
 }
 
-#if 0
-struct mvebu_pinctrl_function *mvebu_pinctrl_find_function_by_name(
-	struct mvebu_pinctrl *pctl, const char *name)
-{
-	unsigned n;
-	for (n = 0; n < pctl->num_functions; n++) {
-		if (strcmp(name, pctl->functions[n].name) == 0)
-			return &pctl->functions[n];
-	}
-	return NULL;
-}
-#endif
-
 /*
  * Common mpp pin configuration registers on MVEBU are
  * registers of eight 4-bit values for each mpp setting.
-- 
1.7.9.5
