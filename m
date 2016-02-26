From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 26 Feb 2016 15:26:06 +0100
Subject: [GIT PULL] ARM: mvebu: soc for v4.6 (#1)
Message-ID: <87egbzo8e9.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for soc for mvebu for v4.6.

Gregory

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.6-1

for you to fetch changes up to 60f23952317a34e8d41c22a6058dcb7bdaf91b96:

  ARM: mvebu: mark mvebu_hwcc_pci_nb as __maybe_unused (2016-02-25 15:39:20 +0100)

----------------------------------------------------------------
mvebu soc for 4.6 (part 1)

randconfig warning fixes for mvebu SoCs

----------------------------------------------------------------
Arnd Bergmann (3):
      ARM: orion: only select I2C_BOARDINFO when using I2C
      ARM: mv78xx0: avoid unused function warning
      ARM: mvebu: mark mvebu_hwcc_pci_nb as __maybe_unused

 arch/arm/mach-dove/Kconfig      |  2 +-
 arch/arm/mach-mv78xx0/common.c  |  5 ++---
 arch/arm/mach-mvebu/coherency.c |  2 +-
 arch/arm/mach-orion5x/Kconfig   | 18 +++++++++---------
 4 files changed, 13 insertions(+), 14 deletions(-)
