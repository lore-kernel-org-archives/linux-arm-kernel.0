From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 24 Feb 2016 18:05:03 +0800
Subject: [PATCH v1 0/4] Add clock ids for RK3228 HDMI/VOP modules
Message-ID: <1456308303-29706-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add clocks ids for RK3228 HDMI/VOP modules which driver already have been
posted.

RK3228 HDMI driver: https://patchwork.kernel.org/patch/7974671
RK3228 VOP driver: https://patchwork.kernel.org/patch/7952591

Yakir Yang (4):
  clk: rockchip: add the new clock ids for RK3228 VOP
  clk: rockchip: set the clock ids for RK3228 VOP
  clk: rockchip: add the new clock ids for RK3228 HDMI
  clk: rockchip: set the clock ids for RK3228 HDMI

 drivers/clk/rockchip/clk-rk3228.c      | 14 +++++++-------
 include/dt-bindings/clock/rk3228-cru.h | 10 ++++++++++
 2 files changed, 17 insertions(+), 7 deletions(-)

-- 
1.9.1
