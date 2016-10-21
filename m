From: zhengxing@rock-chips.com (Xing Zheng)
Date: Fri, 21 Oct 2016 12:03:40 +0800
Subject: [PATCH] clk: rockchip: add 533.25MHz to rk3399 clock rates table
Message-ID: <1477022620-8143-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to get the accurate 533.25MHz for the DP display.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3399.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 2c7cba7..a87cb49 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -93,6 +93,7 @@ static struct rockchip_pll_rate_table rk3399_pll_rates[] = {
 	RK3036_PLL_RATE( 676000000, 3, 169, 2, 1, 1, 0),
 	RK3036_PLL_RATE( 600000000, 1, 75, 3, 1, 1, 0),
 	RK3036_PLL_RATE( 594000000, 1, 99, 4, 1, 1, 0),
+	RK3036_PLL_RATE( 533250000, 8, 711, 4, 1, 1, 0),
 	RK3036_PLL_RATE( 504000000, 1, 63, 3, 1, 1, 0),
 	RK3036_PLL_RATE( 500000000, 6, 250, 2, 1, 1, 0),
 	RK3036_PLL_RATE( 408000000, 1, 68, 2, 2, 1, 0),
-- 
2.7.4
