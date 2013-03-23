From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 23 Mar 2013 10:51:44 +0100
Subject: [GIT PULL] sunxi drivers additions for 3.10, take 1
Message-ID: <514D7B30.7080002@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please consider pulling the following pull request that contains
drivers to be included in 3.10. The only addition for now is the clock
driver for the Allwinner A10 and A13.

Thanks,
Maxime

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-drivers-for-3.10

for you to fetch changes up to 6b7724033efb055b07902a2b0a689445ed31b37d:

  arm: sunxi: Add useful information about sunxi clocks (2013-03-23 09:36:58 +0100)

----------------------------------------------------------------
sunxi drivers additions for 3.10

----------------------------------------------------------------
Emilio L?pez (2):
      clk: arm: sunxi: Add a new clock driver for sunxi SOCs
      arm: sunxi: Add useful information about sunxi clocks

 Documentation/arm/sunxi/clocks.txt                |   56 ++++
 Documentation/devicetree/bindings/clock/sunxi.txt |   44 +++
 drivers/clk/Makefile                              |    1 +
 drivers/clk/sunxi/Makefile                        |    5 +
 drivers/clk/sunxi/clk-factors.c                   |  180 ++++++++++
 drivers/clk/sunxi/clk-factors.h                   |   27 ++
 drivers/clk/sunxi/clk-sunxi.c                     |  362 +++++++++++++++++++++
 drivers/clocksource/sunxi_timer.c                 |    4 +-
 include/linux/clk/sunxi.h                         |   22 ++
 9 files changed, 699 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/arm/sunxi/clocks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sunxi.txt
 create mode 100644 drivers/clk/sunxi/Makefile
 create mode 100644 drivers/clk/sunxi/clk-factors.c
 create mode 100644 drivers/clk/sunxi/clk-factors.h
 create mode 100644 drivers/clk/sunxi/clk-sunxi.c
 create mode 100644 include/linux/clk/sunxi.h

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
