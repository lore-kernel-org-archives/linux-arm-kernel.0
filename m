From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 25 Apr 2016 19:38:55 +0200
Subject: [PULL REQUEST v2] ARM: OXNAS pull request for 4.7
Message-ID: <1461605935-19775-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the ARM pull request for the OXNAS platform.
It also includes one-line change into irq-versatile-fpga.

The following changes since commit c3b46c73264b03000d1e18b22f5caf63332547c9:

  Linux 4.6-rc4 (2016-04-17 19:13:32 -0700)

are available in the git repository at:

  https://github.com/superna9999/linux.git tags/ox810se-arm-v4.6-rc4

for you to fetch changes up to 34e9a2d6bea252563b333bd8368c5145fa5a9fad:

  MAINTAINERS: add maintainer entry for ARM/OXNAS platform (2016-04-18 11:39:41 +0200)

----------------------------------------------------------------
ARM: Add OXNAS Platform Support

Changes since v1 pull request : http://lkml.kernel.org/r/1459521689-13962-1-git-send-email-narmstrong at baylibre.com
- rebase on 4.6 rc4

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
