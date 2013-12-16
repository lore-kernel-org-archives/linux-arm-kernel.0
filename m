From: alex.elder@linaro.org (Alex Elder)
Date: Mon, 16 Dec 2013 09:26:29 -0600
Subject: [GIT PULL] clk: initial support  for Broadcom Kona clocks
Message-ID: <52AF1BA5.6000902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike, please pull the following for 3.14.  It adds clock support
for Broadcom SoCs having "Kona" clock control units.  Thanks.

					-Alex

The following changes since commit 1459c837036a44e2dcf14a9452ed330201fb23b5:

  clk: si570: Add a driver for SI570 oscillators (2013-12-14 21:01:35 -0800)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/broadcom/kernel.git
pull/mturquette-kona-clocks

for you to fetch changes up to 143522e704d105bd2b3cbbca6e8fb2d217866ec0:

  clk: bcm281xx: add initial clock framework support (2013-12-16
07:34:52 -0600)

----------------------------------------------------------------
Alex Elder (2):
      clk: bcm281xx: define kona clock binding
      clk: bcm281xx: add initial clock framework support

 .../devicetree/bindings/clock/bcm-kona-clock.txt   |   93 ++
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/bcm/Kconfig                            |    8 +
 drivers/clk/bcm/Makefile                           |    3 +
 drivers/clk/bcm/clk-bcm281xx.c                     |  416 ++++++++
 drivers/clk/bcm/clk-kona-setup.c                   |  769 +++++++++++++++
 drivers/clk/bcm/clk-kona.c                         | 1033
++++++++++++++++++++
 drivers/clk/bcm/clk-kona.h                         |  414 ++++++++
 include/dt-bindings/clock/bcm281xx.h               |   65 ++
 10 files changed, 2803 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/clock/bcm-kona-clock.txt
 create mode 100644 drivers/clk/bcm/Kconfig
 create mode 100644 drivers/clk/bcm/Makefile
 create mode 100644 drivers/clk/bcm/clk-bcm281xx.c
 create mode 100644 drivers/clk/bcm/clk-kona-setup.c
 create mode 100644 drivers/clk/bcm/clk-kona.c
 create mode 100644 drivers/clk/bcm/clk-kona.h
 create mode 100644 include/dt-bindings/clock/bcm281xx.h
