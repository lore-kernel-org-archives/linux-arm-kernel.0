From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  8 Aug 2017 15:15:38 +0800
Subject: [PATCH v3 0/9] clk: rockchip: support clk for RV1108 Soc
Message-ID: <1502176547-30817-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RV1108 submit is too much, make the CLK part out to review alone.

Changes in v3:
[PATCH v3 1/9] None
[PATCH v3 2/9] None
[PATCH v3 3/9] None
[PATCH v3 4/9] None
[PATCH v3 5/9] None
[PATCH v3 6/9] fix up the structure patch-contents
[PATCH v3 7/9] fix up the structure patch-contents
[PATCH v3 8/9] fix up the structure patch-contents
[PATCH v3 8/9] None

Changes in v2:
[PATCH v2 1/9] split the rename and intentation fix part
[PATCH v2 2/9] None
[PATCH v2 3/9] None
[PATCH v2 4/9] split the new added clks and rename.
[PATCH v2 5/9] None
[PATCH v2 6/9] None
[PATCH v2 7/9] None
[PATCH v2 8/9] None
[PATCH v3 9/9] None

Elaine Zhang (9):
  clk: rockchip: add more clk ids for rv1108
  clk: rockchip: rename the clk id for HCLK_I2S1_2CH
  clk: rockchip: fix up the indentation stuff for RV1108 SoC
  clk: rockchip: support more rates for cpuclk
  clk: rockchip: fix up the pll clks error for rv1108 SoC
  clk: rockchip: support more clks for rv1108
  clk: rockchip: fix up some clks describe error for rv1108 SoC
  clk: rockchip: rename some of clks for rv1108 SoC
  clk: rockchip: add some critical clocks for rv1108 SoC

 drivers/clk/rockchip/clk-rv1108.c      | 476 +++++++++++++++++++++++++++------
 include/dt-bindings/clock/rv1108-cru.h | 123 +++++++--
 2 files changed, 494 insertions(+), 105 deletions(-)

-- 
1.9.1
