From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 18 Jul 2011 16:44:15 +0900
Subject: [GIT PULL] ARM: consolidate clkdev header files for v3.1
Message-ID: <20110718074414.GA23995@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull clkdev header files consolidation.

Thank you,
Kyungin Park

The following changes since commit 1765a367a3b5d5e9692949b0c5ec933eff2c0701:

  Merge branch 'gpio/merge' of git://git.secretlab.ca/git/linux-2.6 (2011-07-15 18:03:30 -0700)

are available in the git repository at:

  git://git.infradead.org/users/kmpark/linux-2.6-samsung clkdev

Kyungmin Park (1):
      Consolidate the clkdev header files

 arch/arm/Kconfig                             |    6 ++++
 arch/arm/include/asm/clkdev.h                |    5 ++++
 arch/arm/mach-at91/include/mach/clkdev.h     |    7 -----
 arch/arm/mach-bcmring/include/mach/clkdev.h  |    7 -----
 arch/arm/mach-davinci/include/mach/clkdev.h  |   15 -----------
 arch/arm/mach-ep93xx/include/mach/clkdev.h   |   11 --------
 arch/arm/mach-lpc32xx/include/mach/clkdev.h  |   25 -------------------
 arch/arm/mach-mmp/include/mach/clkdev.h      |    7 -----
 arch/arm/mach-msm/include/mach/clkdev.h      |   19 --------------
 arch/arm/mach-mxs/include/mach/clkdev.h      |    7 -----
 arch/arm/mach-nomadik/include/mach/clkdev.h  |    7 -----
 arch/arm/mach-nuc93x/include/mach/clkdev.h   |    7 -----
 arch/arm/mach-omap1/include/mach/clkdev.h    |    5 ----
 arch/arm/mach-omap2/include/mach/clkdev.h    |    5 ----
 arch/arm/mach-pnx4008/include/mach/clkdev.h  |    7 -----
 arch/arm/mach-pxa/include/mach/clkdev.h      |    7 -----
 arch/arm/mach-spear3xx/include/mach/clkdev.h |   19 --------------
 arch/arm/mach-spear6xx/include/mach/clkdev.h |   19 --------------
 arch/arm/mach-tegra/include/mach/clkdev.h    |   34 --------------------------
 arch/arm/mach-ux500/include/mach/clkdev.h    |    7 -----
 arch/arm/mach-w90x900/include/mach/clkdev.h  |    7 -----
 arch/arm/plat-mxc/include/mach/clkdev.h      |    7 -----
 arch/arm/plat-omap/include/plat/clkdev.h     |   13 ----------
 arch/arm/plat-spear/include/plat/clkdev.h    |   20 ---------------
 arch/arm/plat-tcc/include/mach/clkdev.h      |    7 -----
 drivers/clk/Kconfig                          |    3 ++
 26 files changed, 14 insertions(+), 269 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-msm/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-nuc93x/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/clkdev.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/clkdev.h
 delete mode 100644 arch/arm/plat-omap/include/plat/clkdev.h
 delete mode 100644 arch/arm/plat-spear/include/plat/clkdev.h
 delete mode 100644 arch/arm/plat-tcc/include/mach/clkdev.h
