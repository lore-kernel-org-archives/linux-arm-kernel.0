From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2017 00:08:10 +0100
Subject: [GIT PULL 3/7] ARM: SoC 64-bit changes for v4.11
In-Reply-To: <8729461.VkrRdW7LzJ@wuerfel>
References: <8729461.VkrRdW7LzJ@wuerfel>
Message-ID: <7296982.y7VePBZAih@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-arm64

for you to fetch changes up to 971d33cb422b3109fe3df034440debc3f4fe8423:

  MAINTAINERS: Add Cavium ThunderX2 entry (2017-02-09 16:26:26 +0100)

----------------------------------------------------------------
ARM: SoC 64-bit changes for v4.11

Changes to platform code for 64-bit ARM platforms, only trivial
stuff this time, a few defconfig changes to enable drivers, and
a new entry for the Cavium ThunderX2 platform.

----------------------------------------------------------------
Andreas F?rber (1):
      MAINTAINERS: Extend ARM/Mediatek SoC support section

Jayachandran C (3):
      arm64: add THUNDER2 processor family
      arm64: add ARCH_THUNDER2 to defconfig
      MAINTAINERS: Add Cavium ThunderX2 entry

Masahiro Yamada (1):
      arm64: defconfig: enable CONFIG_MMC_SDHCI_CADENCE

Olof Johansson (1):
      Merge tag 'mvebu-defconfig64-4.11-1' of git://git.infradead.org/linux-mvebu into next/arm64

Thomas Petazzoni (1):
      arm64: defconfig: enable XORv2 for Marvell Armada 7K/8K

 MAINTAINERS                  | 9 +++++++++
 arch/arm64/Kconfig.platforms | 7 +++++++
 arch/arm64/configs/defconfig | 3 +++
 3 files changed, 19 insertions(+)
