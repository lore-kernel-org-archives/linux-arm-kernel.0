From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  1 Aug 2017 09:17:02 +0800
Subject: [PATCH v4 0/2] clk: rockchip: support clk drivers for RK3126 SoC.
Message-ID: <1501550224-6875-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

changed in V4:
modify the document description for rk3126 clock.

changed in V3:
add documentation for rk3126 clock

Elaine Zhang (2):
  clk: rockchip: rk3128: modify rk3128 clk driver to support rk3126
  dt-bindings: add documentation for rk3126 clock

 .../bindings/clock/rockchip,rk3128-cru.txt         |  8 ++-
 drivers/clk/rockchip/clk-rk3128.c                  | 69 +++++++++++++++++-----
 2 files changed, 60 insertions(+), 17 deletions(-)

-- 
1.9.1
