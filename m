From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 26 Apr 2016 10:06:21 +0200
Subject: [PULL REQUEST v3] ARM: OXNAS pull request for 4.7
Message-ID: <1461657981-22942-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the ARM pull request for the OXNAS platform.
It also includes one-line change into irq-versatile-fpga.

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  https://github.com/superna9999/linux.git tags/ox810se-arm-v4.6-rc3

for you to fetch changes up to e557959d5599037899dd974f4a79419c664dcf79:

  MAINTAINERS: add maintainer entry for ARM/OXNAS platform (2016-04-26 09:50:53 +0200)

----------------------------------------------------------------
ARM: Add OXNAS Platform Support

Changes since v2 pull request : http://lkml.kernel.org/r/1461605971-19866-1-git-send-email-narmstrong at baylibre.com
- rebase on 4.6 rc3

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
