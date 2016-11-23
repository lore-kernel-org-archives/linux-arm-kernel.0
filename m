From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 23 Nov 2016 12:06:27 +0100
Subject: [PATCH v3 3/3] bus: da8xx-mstpri: fix a typo
In-Reply-To: <1479899187-10199-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479899187-10199-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1479899187-10199-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Should have been priorities.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/bus/da8xx-mstpri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/da8xx-mstpri.c b/drivers/bus/da8xx-mstpri.c
index 064eeb9..b17ba97 100644
--- a/drivers/bus/da8xx-mstpri.c
+++ b/drivers/bus/da8xx-mstpri.c
@@ -245,7 +245,7 @@ static int da8xx_mstpri_probe(struct platform_device *pdev)
 
 	prio_list = da8xx_mstpri_get_board_prio();
 	if (!prio_list) {
-		dev_err(dev, "no master priotities defined for board '%s'\n",
+		dev_err(dev, "no master priorities defined for board '%s'\n",
 			da8xx_mstpri_machine_get_compatible());
 		return -EINVAL;
 	}
-- 
2.9.3
