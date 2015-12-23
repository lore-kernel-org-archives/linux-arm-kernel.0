From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 23 Dec 2015 17:05:54 +0800
Subject: [PATCH 1/2] clk: rockchip: rk3036: rename emac ext source clock
Message-ID: <1450861555-11213-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only support rmii in the RK3036, so we should use the correct
ext clock name.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3036.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 7333b053..1016836 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -133,7 +133,7 @@ PNAME(mux_spdif_p)	= { "spdif_src", "spdif_frac", "xin12m" };
 PNAME(mux_uart0_p)	= { "uart0_src", "uart0_frac", "xin24m" };
 PNAME(mux_uart1_p)	= { "uart1_src", "uart1_frac", "xin24m" };
 PNAME(mux_uart2_p)	= { "uart2_src", "uart2_frac", "xin24m" };
-PNAME(mux_mac_p)	= { "mac_pll_src", "ext_gmac" };
+PNAME(mux_mac_p)	= { "mac_pll_src", "rmii_clkin" };
 PNAME(mux_dclk_p)	= { "dclk_lcdc", "dclk_cru" };
 
 static struct rockchip_pll_clock rk3036_pll_clks[] __initdata = {
-- 
1.7.9.5
