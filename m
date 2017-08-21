From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon, 21 Aug 2017 10:30:25 +0800
Subject: [PATCH v1 0/3] clk: rockchip: rv1108: support mac clk
Message-ID: <1503282628-23542-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Elaine Zhang (3):
  clk: rockchip: add rv1108 ACLK_GAMC and PCLK_GMAC ID
  clk: rockchip: rv1108: add ACLK_GMAC and PCLK_GMAC clk id
  clk: rockchip: rv1108: rename macphy to mac

 drivers/clk/rockchip/clk-rv1108.c      | 14 ++++++++------
 include/dt-bindings/clock/rv1108-cru.h |  8 +++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

-- 
1.9.1
