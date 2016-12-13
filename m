From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue, 13 Dec 2016 16:47:46 +0800
Subject: [PATCH v1 0/3] clk: rockchip: support clk controller for rk3328 SoC
Message-ID: <1481618869-1239-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Elaine Zhang (3):
  clk: rockchip: add dt-binding header for rk3328
  clk: rockchip: add clock controller for rk3328
  clk: rockchip: add new pll-type for rk3328 and similar socs

 drivers/clk/rockchip/Makefile          |    1 +
 drivers/clk/rockchip/clk-pll.c         |   13 +-
 drivers/clk/rockchip/clk-rk3328.c      | 1068 ++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.h             |   23 +
 include/dt-bindings/clock/rk3328-cru.h |  403 ++++++++++++
 5 files changed, 1507 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/rockchip/clk-rk3328.c
 create mode 100644 include/dt-bindings/clock/rk3328-cru.h

-- 
1.9.1
