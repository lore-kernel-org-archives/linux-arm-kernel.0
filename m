From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 14 Dec 2016 18:11:38 +0800
Subject: [PATCH 0/3] Add and export clk-480m clocks for ehci and ohci on RK3399
Message-ID: <1481710301-1454-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
  This patches would like to fix the USB suspend block without
the clk-480m clock. Let's add and export them to control them.

Thanks.


William wu (1):
  arm64: dts: rockchip: add clk-480m for ehci and ohci of rk3399

Xing Zheng (2):
  clk: rockchip: rk3399: add USBPHYx_480M_SRC clock IDs
  clk: rockchip: rk3399: export 480M_SRC clocks id for usbphy0/usbphy1

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 28 ++++++++++++++++++++--------
 drivers/clk/rockchip/clk-rk3399.c        |  4 ++--
 include/dt-bindings/clock/rk3399-cru.h   |  2 ++
 3 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.7.4
