From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 13 Dec 2013 17:07:11 -0600
Subject: [GIT PULL] clk: socfpga: Clean-ups for 3.14
Message-ID: <1386976031-21651-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Please pull in these 3 patches that cleans up the SOCFPGA clock driver.

Thanks,

Dinh

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-clk-for-3.14

for you to fetch changes up to be4cf9f262a069a91d095b9c17aed44e12699236:

  clk: socfpga: Remove socfpga_init_clocks (2013-12-13 16:54:38 -0600)

----------------------------------------------------------------
SOCFPGA clk cleanups for 3.14

----------------------------------------------------------------
Dinh Nguyen (3):
      clk: socfpga: Map the clk manager base address in the clock driver
      clk: socfpga: Look for the GPIO_DB_CLK by its offset
      clk: socfpga: Remove socfpga_init_clocks

 arch/arm/mach-socfpga/socfpga.c |    5 -----
 drivers/clk/socfpga/clk.c       |   31 +++++++++++++++++--------------
 2 files changed, 17 insertions(+), 19 deletions(-)
