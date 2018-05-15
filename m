From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 May 2018 16:52:22 +0530
Subject: [PATCH v2 0/2] clk: davinci: some more fixes
Message-ID: <20180515112224.30122-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Some more fixes to make DM646x and DM365 EVMs boot after
common clock framework conversion. With this, I have tested
all DaVinci SoCs.

See individual patches for v2 changes.

Sekhar Nori (2):
  clk: davinci: pll-dm646x: keep PLL2 SYSCLK1 always enabled
  clk: davinci: psc-dm365: fix few clocks

 drivers/clk/davinci/pll-dm646x.c |  2 +-
 drivers/clk/davinci/psc-dm365.c  | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.16.2
