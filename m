From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 May 2014 10:57:03 -0400
Subject: [GIT PULL] clk: mvebu: changes for v3.16
Message-ID: <20140508145703.GC12708@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

Here are the mvebu clock changes this time around.  Pretty easy, just
one brand new driver.  This has been in -next for a while and is part of
the awesome series by Thomas converting the legacy orion5x platform to
devicetree.

Please pull.

thx,

Jason.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/clk-mvebu-3.16

for you to fetch changes up to 66ecbfea762ad28bd108db76775483b491068b92:

  clk: mvebu: add Orion5x clock driver (2014-04-26 01:03:55 +0000)

----------------------------------------------------------------
clk mvebu changes for v3.16

 - orion5x: brand new driver

----------------------------------------------------------------
Thomas Petazzoni (1):
      clk: mvebu: add Orion5x clock driver

 .../devicetree/bindings/clock/mvebu-core-clock.txt |   8 +
 drivers/clk/mvebu/Kconfig                          |   4 +
 drivers/clk/mvebu/Makefile                         |   1 +
 drivers/clk/mvebu/orion.c                          | 210 +++++++++++++++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 drivers/clk/mvebu/orion.c
