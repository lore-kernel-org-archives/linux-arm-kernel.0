From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon,  1 Aug 2016 12:23:03 +0800
Subject: [RESEND PATCH 0/6] fix and optimize some clock configuration for the
 RK3399 platfom
Message-ID: <1470025389-4094-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi:
  In the development work, we found that some of the previous
incorrect clock configuration on the RK3399 platform, we should
fix and optimize them.


Elaine Zhang (1):
  clk: rockchip: rk3399: delete the CLK_IGNORE_UNUSED for aclk_pcie

Xing Zheng (5):
  clk: rockchip: rk3399: export USBPHYx_480M_SRC clock IDs
  clk: rockchip: rk3399: export 480M_SRC clock id for usbphy0/usbphy1
  clk: rockchip: rk3399: fix incorrect aclk_emmc source gate bits
  clk: rockchip: rk3399: add 65MHz and 106.5MHz clocks for HDMI
  clk: rockchip: rk3399: Add support frac mode frequencies

 drivers/clk/rockchip/clk-rk3399.c      |   35 +++++++++++++++++++++++++-------
 include/dt-bindings/clock/rk3399-cru.h |    2 ++
 2 files changed, 30 insertions(+), 7 deletions(-)

-- 
1.7.9.5
