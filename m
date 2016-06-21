From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 21 Jun 2016 12:53:26 +0800
Subject: [PATCH 0/5] Fix and improve clock controller for the RK322x SoCs
Message-ID: <1466484811-26923-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
  These patchset fix some clocks bugs, and improve clock configuration
for i2s/spdif/MAC on RK322x SoCs.

Thanks.


Xing Zheng (5):
  clk: rockchip: rk3228: fix incorrect clock node names
  clk: rockchip: rk3228: include downstream muxes into fractional
    dividers
  clk: rockchip: rk3228: export related i2s/spdif clocks
  clk: rockchip: rk3228: rename sclk_macphy_50m to sclk_mac_extclk
  clk: rockchip: rk3228: export related MAC clocks

 drivers/clk/rockchip/clk-rk3228.c      |  125 +++++++++++++++++++-------------
 include/dt-bindings/clock/rk3228-cru.h |   15 ++++
 2 files changed, 89 insertions(+), 51 deletions(-)

-- 
1.7.9.5
