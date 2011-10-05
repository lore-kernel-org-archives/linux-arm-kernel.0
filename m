From: robherring2@gmail.com (Rob Herring)
Date: Wed, 05 Oct 2011 11:41:05 -0500
Subject: [PULL] Devicetree for 3.2
Message-ID: <4E8C88A1.4090308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

Please pull for 3.2. These commits don't have any dependencies and are
not dependencies for me, so they don't need to go in thru arm-soc.

Rob

The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:

  Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)

are available in the git repository at:
  git://git.jdl.com/software/linux-3.0.git for-grant

Rob Herring (4):
      MAINTAINERS: update devicetree maintainers
      of/irq: of_irq_find_parent: check for parent equal to child
      devicetree: Add ARM pl061 gpio controller binding doc
      devicetree: Add ARM pl022 spi controller binding doc

 .../devicetree/bindings/gpio/pl061-gpio.txt        |   10 ++++++++++
 .../devicetree/bindings/spi/spi_pl022.txt          |   12 ++++++++++++
 MAINTAINERS                                        |    2 ++
 drivers/of/irq.c                                   |   14 +++++++-------
 4 files changed, 31 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/pl061-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi_pl022.txt
