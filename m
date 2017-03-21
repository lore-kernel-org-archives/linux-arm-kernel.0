From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Mar 2017 16:38:20 +0800
Subject: [PATCH 0/3] ZX296718 clock update for VGA support
Message-ID: <1490085503-15713-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

This is a series which makes necessary changes on zx296718 clock driver
in order to support VGA display.  The second patch actually fixes a bug
that is discovered by VGA driver debugging.

Shawn Guo (3):
  clk: zte: set CLK_SET_RATE_PARENT for a few zx296718 clocks
  zte: clk: pd_bit is not 0 on zx296718
  clk: zte: add pll_vga clock for zx296718

 drivers/clk/zte/clk-zx296718.c | 30 +++++++++++++++++++++++++++---
 drivers/clk/zte/clk.c          | 12 +++++++++++-
 drivers/clk/zte/clk.h          |  6 +++++-
 3 files changed, 43 insertions(+), 5 deletions(-)

-- 
1.9.1
