From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon, 28 Dec 2015 17:03:49 +0800
Subject: [RESEND PATCH v1 0/4] fix some clock configuration for the RK3036
 platform
Message-ID: <1451293433-32392-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi:
  In the development work, we found that some of the previous incorrect
clock configuration on the RK3036 platform, we should fix them.



Xing Zheng (4):
  clk: rockchip: rk3036: fix the FLAGs for clock mux
  clk: rockchip: rk3036: fix uarts clock error
  clk: rockchip: rk3036: rename emac ext source clock
  clk: rockchip: rk3036: fix and add node id for emac clock

 drivers/clk/rockchip/clk-rk3036.c      |   33 ++++++++++++++++----------------
 include/dt-bindings/clock/rk3036-cru.h |    2 ++
 2 files changed, 19 insertions(+), 16 deletions(-)

-- 
1.7.9.5
