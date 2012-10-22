From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 22 Oct 2012 15:57:56 +0200
Subject: [PATCH 0/5] clk: ux500: Add clock lookups for u8500
Message-ID: <1350914281-1332-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Step by step, clock lookups for u8500 are being added in this set
of patches.

These patches will require additional patches for sound/soc/ux500/
driver as well as drivers/i2c/busses/i2c-nomadik driver to prevent
the boot for ux500 from break. Those patches are being merged through
separate trees.

Ulf Hansson (5):
  clk: ux500: Register i2c clock lookups for u8500
  clk: ux500: Register ssp clock lookups for u8500
  clk: ux500: Register msp clock lookups for u8500
  clk: ux500: Update rtc clock lookup for u8500
  clk: ux500: Register slimbus clock lookups for u8500

 drivers/clk/ux500/u8500_clk.c |   50 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

-- 
1.7.10
