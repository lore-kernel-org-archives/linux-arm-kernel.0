From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Wed, 17 May 2017 15:49:19 +0800
Subject: [PATCH v1 0/3] clk: rockchip: support clk controller for RK312X SoC
Message-ID: <1495007362-10684-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Elaine Zhang (3):
  clk: rockchip: add dt-binding header for rk312x
  dt-bindings: add bindings for rk312x clock controller
  clk: rockchip: add clock controller for rk312x

 .../bindings/clock/rockchip,rk312x-cru.txt         |  56 ++
 drivers/clk/rockchip/Makefile                      |   1 +
 drivers/clk/rockchip/clk-rk312x.c                  | 612 +++++++++++++++++++++
 include/dt-bindings/clock/rk312x-cru.h             | 281 ++++++++++
 4 files changed, 950 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk312x-cru.txt
 create mode 100644 drivers/clk/rockchip/clk-rk312x.c
 create mode 100644 include/dt-bindings/clock/rk312x-cru.h

-- 
1.9.1
