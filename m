From: colin.king@canonical.com (Colin King)
Date: Sun, 24 Apr 2016 23:44:13 +0100
Subject: [PATCH] clk: rockchip: trivial fix of spelling mistake on unsuccessful
Message-ID: <1461537853-10569-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

fix spelling mistake, unsucessful -> unsuccessful

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/rockchip/clk-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 128a6b2..8ac73bc 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -236,7 +236,7 @@ static int rockchip_rk3036_pll_set_params(struct rockchip_clk_pll *pll,
 	/* wait for the pll to lock */
 	ret = rockchip_pll_wait_lock(pll);
 	if (ret) {
-		pr_warn("%s: pll update unsucessful, trying to restore old params\n",
+		pr_warn("%s: pll update unsuccessful, trying to restore old params\n",
 			__func__);
 		rockchip_rk3036_pll_set_params(pll, &cur);
 	}
@@ -475,7 +475,7 @@ static int rockchip_rk3066_pll_set_params(struct rockchip_clk_pll *pll,
 	/* wait for the pll to lock */
 	ret = rockchip_pll_wait_lock(pll);
 	if (ret) {
-		pr_warn("%s: pll update unsucessful, trying to restore old params\n",
+		pr_warn("%s: pll update unsuccessful, trying to restore old params\n",
 			__func__);
 		rockchip_rk3066_pll_set_params(pll, &cur);
 	}
-- 
2.7.4
