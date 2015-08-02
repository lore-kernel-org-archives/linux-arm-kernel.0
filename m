From: colin.king@canonical.com (Colin King)
Date: Mon,  3 Aug 2015 00:10:45 +0100
Subject: [PATCH] pinctrl/mediatek: fix spelling mistake in dev_err error
 message
Message-ID: <1438557045-3590-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial change, fix spelling mistake 'invaild' -> 'invalid' in
dev_err message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index ad1ea16..5af5441 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -702,7 +702,7 @@ static int mtk_pmx_set_mux(struct pinctrl_dev *pctldev,
 
 	ret = mtk_pctrl_is_function_valid(pctl, g->pin, function);
 	if (!ret) {
-		dev_err(pctl->dev, "invaild function %d on group %d .\n",
+		dev_err(pctl->dev, "invalid function %d on group %d .\n",
 				function, group);
 		return -EINVAL;
 	}
-- 
2.5.0
