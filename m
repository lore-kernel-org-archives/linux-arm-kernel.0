From: zhangqing@rock-chips.com (Zhang Qing)
Date: Mon, 25 Jan 2016 08:55:59 -0800
Subject: [PATCH v1 0/3] clk: rockchip: rk3368: fix some error for rk3368 clk
Message-ID: <1453740962-8556-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhangqing <zhangqing@rock-chips.com>

modify edp_24m parent select bit.
enable CLK_SET_RATE_PARENT flag for spdif_8ch and i2s_2ch.

zhangqing (3):
  clk: rockchip: rk3368: fix edp_24m parent
  clk: rockchip: rk3368: enable the CLK_SET_RATE_PARENT flag for
    spdif_8ch
  clk: rockchip: rk3368: enable the CLK_SET_RATE_PARENT flag for i2s_2ch

 drivers/clk/rockchip/clk-rk3368.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
1.9.1
