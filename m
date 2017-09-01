From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri,  1 Sep 2017 10:01:43 +0800
Subject: [PATCH v1 0/3] clk: rockchip: rk3128: fix up some clks
Message-ID: <1504231306-4450-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Elaine Zhang (3):
  clk: rockchip: rk3128: add pclk_pmu as critical clock
  clk: rockchip: rk3128: fix up pvtm and mipi_24m gate regs description
    error
  clk: rockchip: rk3126: add sclk_timer5 as critical clock

 drivers/clk/rockchip/clk-rk3128.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
1.9.1
