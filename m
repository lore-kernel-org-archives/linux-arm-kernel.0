From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  7 Mar 2017 19:16:48 +0800
Subject: [PATCH v2 5/5] clk: rockchip: rk3368: add some clks as critical
In-Reply-To: <1488884719-10350-1-git-send-email-zhangqing@rock-chips.com>
References: <1488884719-10350-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1488885408-17169-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

make pclk_pd_alive, pclk_peri, hclk_peri as critical

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 139d418f448e..024762d3214d 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -858,6 +858,9 @@ enum rk3368_plls {
 	 */
 	"pclk_pwm1",
 	"pclk_pd_pmu",
+	"pclk_pd_alive",
+	"pclk_peri",
+	"hclk_peri",
 };
 
 static void __init rk3368_clk_init(struct device_node *np)
-- 
1.9.1
