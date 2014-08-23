From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:44:12 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v3.18
Message-ID: <cover.1408670623.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v3.18.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.18

for you to fetch changes up to 874ee23c83d888f8824305c277e047c7799f30b9:

  ARM: shmobile: defconfig: enable initrd (2014-08-18 08:07:38 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v3.18

* Enable initrd in shmobile defconfig
* Enable missing hardware support in shmobile and several board defconfigs

----------------------------------------------------------------
Geert Uytterhoeven (7):
      ARM: shmobile: shmobile_defconfig: Enable missing hardware support
      ARM: shmobile: ape6evm_defconfig: Enable missing hardware support
      ARM: shmobile: bockw_defconfig: Enable missing hardware support
      ARM: shmobile: koelsch_defconfig: Enable missing hardware support
      ARM: shmobile: kzm9g_defconfig: Enable missing hardware support
      ARM: shmobile: lager_defconfig: Enable missing hardware support
      ARM: shmobile: marzen_defconfig: Enable missing hardware support

Kevin Hilman (1):
      ARM: shmobile: defconfig: enable initrd

 arch/arm/configs/ape6evm_defconfig  |  9 ++++++++-
 arch/arm/configs/bockw_defconfig    |  2 ++
 arch/arm/configs/koelsch_defconfig  | 17 +++++++++++++++++
 arch/arm/configs/kzm9g_defconfig    |  1 +
 arch/arm/configs/lager_defconfig    |  8 +++++++-
 arch/arm/configs/marzen_defconfig   |  1 +
 arch/arm/configs/shmobile_defconfig |  3 +++
 7 files changed, 39 insertions(+), 2 deletions(-)
