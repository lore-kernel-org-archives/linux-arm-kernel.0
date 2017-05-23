From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue, 23 May 2017 09:11:02 +0800
Subject: [PATCH v3 0/3] clk: rockchip: support clk controller for RK3128 SoC
Message-ID: <1495501865-18512-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver and clk ID\SRST ID it's also applies to the RK3126 SoC.

change in V3:
export clk ID for usb480m and usb480m_phy

change in V2:
rename the rk312x to rk3128.

Elaine Zhang (3):
  clk: rockchip: add dt-binding header for rk3128
  dt-bindings: add bindings for rk3128 clock controller
  clk: rockchip: add clock controller for rk3128

 .../bindings/clock/rockchip,rk3128-cru.txt         |  56 ++
 drivers/clk/rockchip/Makefile                      |   1 +
 drivers/clk/rockchip/clk-rk3128.c                  | 612 +++++++++++++++++++++
 include/dt-bindings/clock/rk3128-cru.h             | 283 ++++++++++
 4 files changed, 952 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
 create mode 100644 drivers/clk/rockchip/clk-rk3128.c
 create mode 100644 include/dt-bindings/clock/rk3128-cru.h

-- 
1.9.1
