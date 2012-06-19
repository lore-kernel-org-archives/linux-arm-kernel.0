From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 19 Jun 2012 14:03:14 +0200
Subject: [PATCH] pinctrl/u300: delete pointless debug print
Message-ID: <1340107394-2364-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This is some leftover from earlier development, let's get rid
of it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-u300.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-u300.c b/drivers/pinctrl/pinctrl-u300.c
index 49b91c2..5f43f9a 100644
--- a/drivers/pinctrl/pinctrl-u300.c
+++ b/drivers/pinctrl/pinctrl-u300.c
@@ -1113,8 +1113,6 @@ static int __devinit u300_pmx_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	pr_err("U300 PMX PROBE\n");
-
 	/* Create state holders etc for this driver */
 	upmx = devm_kzalloc(&pdev->dev, sizeof(*upmx), GFP_KERNEL);
 	if (!upmx)
-- 
1.7.9.2
