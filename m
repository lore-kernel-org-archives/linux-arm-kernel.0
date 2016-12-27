From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue, 27 Dec 2016 14:32:49 +0800
Subject: [PATCH v4 0/4] clk: rockchip: support clk controller for rk3328 SoC
Message-ID: <1482820373-10186-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v4:
  dropping the "rockchip,cru" and "syscon" properties for bindings of rk3328
  adjust the pacth 3 and 4 order.
  move pll_rk3328 to patch 3.
Changes in v3:
  fix up the pll type pll_rk3328 description and use.
Changes in v2:
  add bindings for rk3328 clock controller

Elaine Zhang (4):
  clk: rockchip: add dt-binding header for rk3328
  dt-bindings: add bindings for rk3328 clock controller
  clk: rockchip: add new pll-type for rk3328
  clk: rockchip: add clock controller for rk3328

 .../bindings/clock/rockchip,rk3328-cru.txt         |   57 ++
 drivers/clk/rockchip/Makefile                      |    1 +
 drivers/clk/rockchip/clk-pll.c                     |   16 +-
 drivers/clk/rockchip/clk-rk3328.c                  | 1068 ++++++++++++++++++++
 drivers/clk/rockchip/clk.h                         |   23 +
 include/dt-bindings/clock/rk3328-cru.h             |  403 ++++++++
 6 files changed, 1565 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
 create mode 100644 drivers/clk/rockchip/clk-rk3328.c
 create mode 100644 include/dt-bindings/clock/rk3328-cru.h

-- 
1.9.1
