From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 25 Apr 2014 10:22:02 -0500
Subject: [GIT PULL] clk: socfpga: Clock fix for v3.15
Message-ID: <1398439322-30616-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Please consider pulling this patch for 3.15 fixes.

Thanks,

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-clk-fix-for-3.15

for you to fetch changes up to 812819daf3298040833b4902730821c3441bffc7:

  clk: socfpga: fix clock driver for 3.15 (2014-04-25 10:06:14 -0500)

----------------------------------------------------------------
clk: socfpga: clock fix for v3.15

Currently on 3.15-rc1, the SOCFPGA platform is unable to boot. This patch
fixes the issue and allows the platform to boot.

----------------------------------------------------------------
Dinh Nguyen (1):
      clk: socfpga: fix clock driver for 3.15

 drivers/clk/socfpga/clk-pll.c |    7 +++++++
 drivers/clk/socfpga/clk.c     |   23 +++--------------------
 2 files changed, 10 insertions(+), 20 deletions(-)
