From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  7 Mar 2017 19:05:18 +0800
Subject: [PATCH v2 4/5] clk: rockchip: rk3368: export SCLK_TIMERXX id for
 timers
In-Reply-To: <1488884719-10350-1-git-send-email-zhangqing@rock-chips.com>
References: <1488884719-10350-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1488884719-10350-5-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 6cb474c593e7..139d418f448e 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -835,18 +835,18 @@ enum rk3368_plls {
 	GATE(PCLK_PMU, "pclk_pmu", "pclk_pd_pmu", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(23), 0, GFLAGS),
 
 	/* timer gates */
-	GATE(0, "sclk_timer15", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 11, GFLAGS),
-	GATE(0, "sclk_timer14", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 10, GFLAGS),
-	GATE(0, "sclk_timer13", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 9, GFLAGS),
-	GATE(0, "sclk_timer12", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 8, GFLAGS),
-	GATE(0, "sclk_timer11", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 7, GFLAGS),
-	GATE(0, "sclk_timer10", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 6, GFLAGS),
-	GATE(0, "sclk_timer05", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 5, GFLAGS),
-	GATE(0, "sclk_timer04", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 4, GFLAGS),
-	GATE(0, "sclk_timer03", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 3, GFLAGS),
-	GATE(0, "sclk_timer02", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 2, GFLAGS),
-	GATE(0, "sclk_timer01", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 1, GFLAGS),
-	GATE(0, "sclk_timer00", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 0, GFLAGS),
+	GATE(SCLK_TIMER15, "sclk_timer15", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 11, GFLAGS),
+	GATE(SCLK_TIMER14, "sclk_timer14", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 10, GFLAGS),
+	GATE(SCLK_TIMER13, "sclk_timer13", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 9, GFLAGS),
+	GATE(SCLK_TIMER12, "sclk_timer12", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 8, GFLAGS),
+	GATE(SCLK_TIMER11, "sclk_timer11", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 7, GFLAGS),
+	GATE(SCLK_TIMER10, "sclk_timer10", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 6, GFLAGS),
+	GATE(SCLK_TIMER05, "sclk_timer05", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 5, GFLAGS),
+	GATE(SCLK_TIMER04, "sclk_timer04", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 4, GFLAGS),
+	GATE(SCLK_TIMER03, "sclk_timer03", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 3, GFLAGS),
+	GATE(SCLK_TIMER02, "sclk_timer02", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 2, GFLAGS),
+	GATE(SCLK_TIMER01, "sclk_timer01", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 1, GFLAGS),
+	GATE(SCLK_TIMER00, "sclk_timer00", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 0, GFLAGS),
 };
 
 static const char *const rk3368_critical_clocks[] __initconst = {
-- 
1.9.1
