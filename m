From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 18 Aug 2017 11:49:23 +0800
Subject: [PATCH v1 0/2] clk: rockchip: rk3228: add SCLK_SDIO_SRC clk id
Message-ID: <1503028165-27072-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch exports sdio src clock for dts reference.

Elaine Zhang (2):
  clk: rockchip: add rk3228 sclk_sdio_src ID
  clk: rockchip: rk3228: add SCLK_SDIO_SRC clk id

 drivers/clk/rockchip/clk-rk3228.c      | 2 +-
 include/dt-bindings/clock/rk3228-cru.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.9.1
