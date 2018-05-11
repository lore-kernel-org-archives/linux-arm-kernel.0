From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 11 May 2018 19:40:35 +0530
Subject: [PATCH 0/2] clk: davinci: some more fixes
Message-ID: <20180511141037.25250-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Some more fixes to make DM646x and DM365 EVMs boot after
common clock framework conversion. With this, I have tested
all DaVinci SoCs.

Sekhar Nori (2):
  clk: davinci: pll-dm646x: keep PLL2 SYSCLK1 always enabled
  clk: davinci: psc-dm365: fix few clocks

 drivers/clk/davinci/pll-dm646x.c | 2 +-
 drivers/clk/davinci/psc-dm365.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.16.2
