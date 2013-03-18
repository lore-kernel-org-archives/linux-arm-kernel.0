From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:53:12 +0900
Subject: [GIT PULL] Renesas ARM-based SoC defconfig updates for v3.10
Message-ID: <1363607601-20366-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.10

for you to fetch changes up to db30abdf3c07c564d4af0f991bb7f38b728f9035:

  ARM: mach-shmobile: marzen: add SATA support (2013-03-14 10:28:07 +0100)

----------------------------------------------------------------
Renesas ARM-based SoC defconfig updates for v3.10

----------------------------------------------------------------
Kuninori Morimoto (3):
      ARM: shmobile: armadillo800eva: enable branch prediction on defconfig
      ARM: shmobile: armadillo800eva: enable NEON on defconfig
      ARM: shmobile: armadillo800eva: enable all errata for cache on defconfig

Simon Horman (5):
      ARM: mach-shmobile: mackerel: enable MMCIF and SDHI in defconfig
      ARM: mach-shmobile: mackerel: enable REGULATOR in defconfig
      ARM: mach-shmobile: armadillo800eva: enable REGULATOR in defconfig
      ARM: shmobile: kzm9g: defconfig: do not enable PREEMPT
      ARM: mach-shmobile: kzm9g: do not enable REGULATOR_DUMMY in defconfig

Vladimir Barinov (1):
      ARM: mach-shmobile: marzen: add SATA support

 arch/arm/configs/armadillo800eva_defconfig |    8 +++++++-
 arch/arm/configs/kzm9g_defconfig           |    2 --
 arch/arm/configs/mackerel_defconfig        |    4 ++++
 arch/arm/configs/marzen_defconfig          |    4 ++++
 4 files changed, 15 insertions(+), 3 deletions(-)
