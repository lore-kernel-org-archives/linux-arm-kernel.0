From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 07 Aug 2015 18:01:41 +0200
Subject: [GIT PULL] ARM: mvebu: soc changes for v4.3 #2
Message-ID: <55C4D665.8060702@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for soc for mvebu for v4.3

Gregory

The following changes since commit 482d638f98cc626bf01d4c9f6d6d35fc77d630c8:

  ARM: mvebu: Warn about the wake-up sources not taken into account in suspend (2015-07-28 11:40:47 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.3-2

for you to fetch changes up to 44e259ac909f3b41786cf732a44b5cf8444e098a:

  ARM: dove: create a proper PMU driver for power domains, PMU IRQs and resets (2015-08-05 18:36:49 +0200)

----------------------------------------------------------------
mvebu soc changes for v4.3 (part #2)

SoC part of the Dove PMU series

----------------------------------------------------------------
Russell King (1):
      ARM: dove: create a proper PMU driver for power domains, PMU IRQs and resets

 arch/arm/mach-mvebu/Kconfig  |   1 +
 arch/arm/mach-mvebu/dove.c   |   2 +
 drivers/soc/Makefile         |   1 +
 drivers/soc/dove/Makefile    |   1 +
 drivers/soc/dove/pmu.c       | 412 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/soc/dove/pmu.h |   6 +
 6 files changed, 423 insertions(+)
 create mode 100644 drivers/soc/dove/Makefile
 create mode 100644 drivers/soc/dove/pmu.c
 create mode 100644 include/linux/soc/dove/pmu.h

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
