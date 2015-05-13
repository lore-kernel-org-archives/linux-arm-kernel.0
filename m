From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 13 May 2015 14:08:06 -0500
Subject: [GIT PULL] SoCFPGA clk update for v4.2
Message-ID: <1431544086-11274-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike/Stephen,

Please consider pulling these 2 patches that adds the clock driver for the
SoCFPGA Arria10 platform.

Thanks,
Dinh

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_clk_update_for_v4.2

for you to fetch changes up to 92b449f2de5b0196429d08e2b99ccfbf6182042c:

  clk: socfpga: add a clock driver for the Arria 10 platform (2015-05-13 13:51:14 -0500)

----------------------------------------------------------------
SoCFPGA update for v4.2
- Add clock driver for Arria10 platform
- Update socfpga/clk.h for Arria10 clock driver to use

----------------------------------------------------------------
Dinh Nguyen (2):
      clk: socfpga: update clk.h so for Arria10 platform to use
      clk: socfpga: add a clock driver for the Arria 10 platform

 drivers/clk/socfpga/Makefile         |   1 +
 drivers/clk/socfpga/clk-gate-a10.c   | 187 +++++++++++++++++++++++++++++++++++
 drivers/clk/socfpga/clk-gate.c       |   4 -
 drivers/clk/socfpga/clk-periph-a10.c | 131 ++++++++++++++++++++++++
 drivers/clk/socfpga/clk-pll-a10.c    | 132 +++++++++++++++++++++++++
 drivers/clk/socfpga/clk.c            |   7 +-
 drivers/clk/socfpga/clk.h            |  10 +-
 7 files changed, 466 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/socfpga/clk-gate-a10.c
 create mode 100644 drivers/clk/socfpga/clk-periph-a10.c
 create mode 100644 drivers/clk/socfpga/clk-pll-a10.c
