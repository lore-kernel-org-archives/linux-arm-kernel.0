From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon, 19 Dec 2016 09:56:09 +0800
Subject: [PATCH v2 0/4] clk: rockchip: support clk controller for rk3328 SoC
Message-ID: <1482112573-11613-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:
  add bindings for rk3328 clock controller

Elaine Zhang (4):
  clk: rockchip: add dt-binding header for rk3328
  dt-bindings: add bindings for rk3328 clock controller
  clk: rockchip: add clock controller for rk3328
  clk: rockchip: add new pll-type for rk3328

 .../bindings/clock/rockchip,rk3328-cru.txt         |   57 ++
 drivers/clk/rockchip/Makefile                      |    1 +
 drivers/clk/rockchip/clk-pll.c                     |   13 +-
 drivers/clk/rockchip/clk-rk3328.c                  | 1068 ++++++++++++++++++++
 drivers/clk/rockchip/clk.h                         |   23 +
 include/dt-bindings/clock/rk3328-cru.h             |  403 ++++++++
 6 files changed, 1564 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
 create mode 100644 drivers/clk/rockchip/clk-rk3328.c
 create mode 100644 include/dt-bindings/clock/rk3328-cru.h

-- 
1.9.1
