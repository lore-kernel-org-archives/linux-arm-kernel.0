From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 12 Nov 2012 10:33:41 -0800
Subject: common clk fixes for 3.7-rc6
Message-ID: <20121112183341.17970.71457@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://git.linaro.org/people/mturquette/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 3d930678034e756d0960d214412d344772b21109:

  clk: ux500: Register slimbus clock lookups for u8500 (2012-11-12 10:20:23 -0800)

----------------------------------------------------------------
Missing clkdev entries are causing regressions on the U8500 platform.
This pull request contains those missing clkdev entries which are needed
to boot that platform.

----------------------------------------------------------------
Ulf Hansson (5):
      clk: ux500: Register i2c clock lookups for u8500
      clk: ux500: Register ssp clock lookups for u8500
      clk: ux500: Register msp clock lookups for u8500
      clk: ux500: Update rtc clock lookup for u8500
      clk: ux500: Register slimbus clock lookups for u8500

 drivers/clk/ux500/u8500_clk.c |   50 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)
