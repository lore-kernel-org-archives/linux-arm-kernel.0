From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 2 Jul 2018 21:31:16 +0000
Subject: [PATCH v2 0/2] clk: meson-axg: add pcie related clocks
Message-ID: <20180702213118.19222-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series try to add clocks for the pcie driver,
Due to ASIC desigin, the mipi clock is also required by the pcie
controller, so we also added in this patch series.


Changes since v1 at [1]:
  -- Separate dt-binding header files
  -- use table to exclude unwanted clock parent

[1] https://lkml.kernel.org/r/20180621122620.13195-1-yixun.lan at amlogic.com

Yixun Lan (2):
  clk: meson-axg: add pcie and mipi clock bindings
  clk: meson-axg: add clocks required by pcie driver

 drivers/clk/meson/axg.c              | 148 +++++++++++++++++++++++++++
 drivers/clk/meson/axg.h              |   6 +-
 include/dt-bindings/clock/axg-clkc.h |   3 +
 3 files changed, 156 insertions(+), 1 deletion(-)

-- 
2.18.0
