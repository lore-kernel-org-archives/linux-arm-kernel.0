From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 1 Dec 2013 12:29:14 -0500
Subject: [GIT PULL] irqchip: dove: drivers for v3.14
Message-ID: <20131201172914.GV2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

Here's an mvebu driver we've had on the ML for a while, and it's been in
-next for 5 days.

thx,

Jason.


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-irqchip-3.14

for you to fetch changes up to 40b367d95fb3d60fc1edb9ba8f6ef52272e48936:

  irqchip: irq-dove: Add PMU interrupt controller. (2013-11-26 15:04:53 +0000)

----------------------------------------------------------------
mvebu irqchip changes for v3.14

 - add Dove PMU interrupt controller

----------------------------------------------------------------
Andrew Lunn (1):
      irqchip: irq-dove: Add PMU interrupt controller.

 .../interrupt-controller/marvell,dove-pmu-intc.txt |  17 +++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-dove.c                         | 126 +++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,dove-pmu-intc.txt
 create mode 100644 drivers/irqchip/irq-dove.c
