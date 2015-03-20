From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 20 Mar 2015 11:12:46 +0100
Subject: [GIT PULL] clk: mvebu changes for 4.1
Message-ID: <550BF29E.1030003@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

Here is the first pull request for the clocks for mvebu for v4.1.

It is a pretty small one and I don't expect an other one.

Gregory

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-clk-4.1

for you to fetch changes up to 8da6f3c1662a74a39b5ebc773ee27a949b5d7658:

  clk: mvebu: add Marvell Armada 39x driver (2015-03-04 15:18:53 +0100)

----------------------------------------------------------------
clock changes for mvebu for v4.1

- Add clock support for Armada 39x

----------------------------------------------------------------
Thomas Petazzoni (3):
      devicetree: bindings: update DT bindings for Marvell EBU clock support
      clk: mvebu: extend common code to allow an optional refclk
      clk: mvebu: add Marvell Armada 39x driver

 Documentation/devicetree/bindings/clock/mvebu-core-clock.txt  |   9 +++++++++
 Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt |  15 ++++++++++++++-
 drivers/clk/mvebu/Kconfig                                     |   4 ++++
 drivers/clk/mvebu/Makefile                                    |   1 +
 drivers/clk/mvebu/armada-39x.c                                | 156
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/mvebu/common.c                                    |  17 +++++++++++++++++
 drivers/clk/mvebu/common.h                                    |   1 +
 7 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mvebu/armada-39x.c


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
