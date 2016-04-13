From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 13 Apr 2016 15:32:50 +0800
Subject: [GIT PULL] i.MX clock fixes for 4.6
Message-ID: <20160413073249.GN28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-clk-fixes-4.6

for you to fetch changes up to 7196c52c9377df0175b510ff5896bda524f7345e:

  clk: imx6q: fix typo in CAN clock definition (2016-04-13 15:27:15 +0800)

----------------------------------------------------------------
The i.MX clock fixes for 4.6:
 - Fix the typo in CAN clock definition which is introduced by commit
   ee36027427c7 ("clk: imx: Add clock support for imx6qp")

----------------------------------------------------------------
Lothar Wa?mann (1):
      clk: imx6q: fix typo in CAN clock definition

 drivers/clk/imx/clk-imx6q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
