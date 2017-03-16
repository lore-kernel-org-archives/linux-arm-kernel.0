From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu, 16 Mar 2017 16:44:50 +0800
Subject: [PATCH v1 0/4] iclk: rockchip: add CLK_IGNORE_UNUSED flag for some
 clks
Message-ID: <1489653894-2440-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Elaine Zhang (4):
  clk: rockchip: rk3036: add CLK_IGNORE_UNUSED flag for pclk_ddrupctl
  clk: rockchip: rk3228: add CLK_IGNORE_UNUSED flag for some clks
  clk: rockchip: rk3288: add CLK_IGNORE_UNUSED flag for some clks
  clk: rockchip: rk3368: add CLK_IGNORE_UNUSED flag for some clks

 drivers/clk/rockchip/clk-rk3036.c |  2 +-
 drivers/clk/rockchip/clk-rk3228.c | 66 ++++++++++++++++++++-------------------
 drivers/clk/rockchip/clk-rk3288.c | 42 ++++++++++++-------------
 drivers/clk/rockchip/clk-rk3368.c | 12 +++----
 4 files changed, 62 insertions(+), 60 deletions(-)

-- 
1.9.1
