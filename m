From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jul 2011 23:51:11 +0200
Subject: [GIT PULL] arm-soc fixes for 3.1, part 3
Message-ID: <1984018.j2tgeA30Sz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

These two patches are for buil regressions instroduced this merge window, please pull.

	Arnd

The following changes since commit e371d46ae45488bcb112a99a7de462e9e3aa6764:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs-2.6 (2011-07-26 18:30:20 -0700)

are available in the git repository at:

  git+ssh://master.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.git/ fixes

Arnd Bergmann (1):
      ARM: zynq: remove incorrectly deleted file

Uwe Kleine-K?nig (1):
      ARM: tegra: only select MACH_HAS_SND_SOC_TEGRA_WM8903 if SND_SOC

 arch/arm/mach-tegra/Kconfig   |    6 +++---
 arch/arm/mach-zynq/Makefile   |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
 delete mode 100644 arch/arm/mach-zynq/board_dt.c
