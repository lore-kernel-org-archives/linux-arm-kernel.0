From: zhengxing@rock-chips.com (Xing Zheng)
Date: Thu,  7 Jan 2016 20:17:32 +0800
Subject: [PATCH v2 0/5] fix some clock configuration for the RK3036 platform
Message-ID: <1452169057-24467-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi:
  In the development work, we found that some of the previous
incorrect clock configuration on the RK3036 platform, we should
fix them.



Xing Zheng (5):
  clk: rockchip: rk3036: fix the FLAGs for clock mux
  clk: rockchip: rk3036: fix uarts clock error
  clk: rockchip: rk3036: fix the div offset for emac clock
  clk: rockchip: rk3036: rename emac ext source clock
  clk: rockchip: rk3036: add HCLK_MAC id for emac

 drivers/clk/rockchip/clk-rk3036.c      |   28 ++++++++++++++--------------
 include/dt-bindings/clock/rk3036-cru.h |    1 +
 2 files changed, 15 insertions(+), 14 deletions(-)

-- 
1.7.9.5
