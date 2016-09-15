From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Sep 2016 14:57:37 +0800
Subject: [PATCH 0/3] clk: sunxi-ng: sun6i-a31: Register offset and clk flag
 fixes
Message-ID: <20160915065740.13664-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are 3 fixes for the new sunxi-ng clk driver for sun6i-a31 recently
introduced for 4.9. The issues were noticed while working on the display
pipeline for the A31/A31s. The second patch follows what Maxime has done
for the A33 CCU driver. The third issue was noticed while doing the first
patch.

I hope we can get this into 4.9 as well, either right in -rc1, or in a
later -rc.

Thanks!

Regards
ChenYu

Chen-Yu Tsai (3):
  clk: sunxi-ng: sun6i-a31: Set CLK_SET_RATE_PARENT for display output
    clocks
  clk: sunxi-ng: sun6i-a31: set CLK_SET_RATE_UNGATE for all PLLs
  clk: sunxi-ng: sun6i-a31: Fix register offset for mipi-csi clk

 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 44 ++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 20 deletions(-)

-- 
2.9.3
