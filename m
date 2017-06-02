From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri,  2 Jun 2017 09:47:22 +0800
Subject: [PATCH v4 0/3] clk: rockchip: support clk controller for RK3128 SoC
Message-ID: <1496368045-17746-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver and clk ID\SRST ID it's also applies to the RK3126 SoC.

change in V4:
remove the clk ID of usb480m_phy

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
 include/dt-bindings/clock/rk3128-cru.h             | 282 ++++++++++
 4 files changed, 951 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
 create mode 100644 drivers/clk/rockchip/clk-rk3128.c
 create mode 100644 include/dt-bindings/clock/rk3128-cru.h

-- 
1.9.1
