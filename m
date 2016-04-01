From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  1 Apr 2016 16:41:29 +0200
Subject: [PATCH 0/3] ARM: OXNAS pull request for 4.7
Message-ID: <1459521689-13962-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the ARM pull request for the OXNAS platform.
It also includes one-line change into irq-versatile-fpga.

The following changes since commit 1e6d88ccf41c7ef2d6c99aa5e7fb9215aa0e5423:

  Merge tag 'nios2-v4.6-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2 (2016-03-30 20:40:42 -0500)

are available in the git repository at:

  https://github.com/superna9999/linux.git tags/ox810se-arm

for you to fetch changes up to b4f122cdd148696e0d8c5f815ac48c5b9ed9de3f:

  MAINTAINERS: add maintainer entry for ARM/OXNAS platform (2016-04-01 15:51:54 +0200)

----------------------------------------------------------------
ARM: Add OXNAS Platform Support

Changes since original v3 patchset :
- Get rid of PLX Technology

v3 patchset : http://lkml.kernel.org/r/1458838215-23314-1-git-send-email-narmstrong at baylibre.com

----------------------------------------------------------------
Neil Armstrong (3):
      irqchip: versatile-fpga: add new compatible for OX810SE SoC
      ARM: Add new mach-oxnas
      MAINTAINERS: add maintainer entry for ARM/OXNAS platform

 MAINTAINERS                          |  9 +++++++++
 arch/arm/Kconfig                     |  2 ++
 arch/arm/mach-oxnas/Kconfig          | 24 ++++++++++++++++++++++++
 drivers/irqchip/irq-versatile-fpga.c |  1 +
 4 files changed, 36 insertions(+)
 create mode 100644 arch/arm/mach-oxnas/Kconfig
