From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 20 Apr 2016 19:06:48 +0800
Subject: [PATCH 0/6] Fix the clock controller driver for the RK3399
Message-ID: <1461150414-29638-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
  This patchset fix some issues and optimized some features for
the RK3399 clock controller in the development process.

Thanks.


Xing Zheng (6):
  clk: rockchip: rk3399: export some necessary clock IDs
  clk: rockchip: rk3399: add some frequencies on the PLL table
  clk: rockchip: rk3399: drop unnecessary CLK_IGNORE_UNUSED flags
  clk: rockchip: rk3399: update necessary critical clocks
  clk: rockchip: rk3399: fix the cifout clock
  clk: rockchip: rk3399: fix the gate bit for i2c4 and i2c8

 drivers/clk/rockchip/clk-rk3399.c      |  416 ++++++++++++++++++--------------
 include/dt-bindings/clock/rk3399-cru.h |    5 +-
 2 files changed, 243 insertions(+), 178 deletions(-)

-- 
1.7.9.5
