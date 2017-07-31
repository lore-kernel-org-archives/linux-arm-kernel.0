From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon, 31 Jul 2017 18:42:06 +0800
Subject: [PATCH v3 0/2] clk: rockchip: support clk drivers for RK3126 SoC.
Message-ID: <1501497728-7805-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

changed in V3:
add documentation for rk3126 clock

Elaine Zhang (2):
  clk: rockchip: rk3128: modify rk3128 clk driver to support rk3126
  dt-bindings: add documentation for rk3126 clock

 .../bindings/clock/rockchip,rk3128-cru.txt         |  6 +-
 drivers/clk/rockchip/clk-rk3128.c                  | 69 +++++++++++++++++-----
 2 files changed, 58 insertions(+), 17 deletions(-)

-- 
1.9.1
