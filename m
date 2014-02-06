From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:27 +0900
Subject: [GIT PULL 00/13] Renesas ARM based SoC Defconfig Updates for v3.15
Message-ID: <cover.1391651074.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider these Renesas ARM based SoC defconfig updates for v3.15.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.15

for you to fetch changes up to 0771ddff31186836f62a20c42e7958bd37f7b4ed:

  ARM: shmobile: ape6evm: enable CONFIG_DEVTMPFS in defconfig (2014-02-04 10:26:04 +0900)

----------------------------------------------------------------
Renesas ARM based SoC Defconfig Updates for v3.15

* Renesas ARM based SoC boards (Global)
  enable CONFIG_DEVTMPFS in defconfig

* r8a7791 SoC (R-Car M2) based Koelsch board
  - Enable SATA

* r8a7790 SoC (R-Car H2) based Lager board
  - Enable SATA, VIN and ADV7180 decoder in defconfig

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: koelsch: Enable DEVTMPFS_MOUNT in defconfig

Kuninori Morimoto (9):
      ARM: shmobile: marzen: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: mackerel: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: lager: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: kzm9g: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: kzm9d: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: genmai: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: bockw: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: armadillo: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: ape6evm: enable CONFIG_DEVTMPFS in defconfig

Valentine Barshak (3):
      ARM: shmobile: lager: Enable VIN along with ADV7180 decoder in defconfig
      ARM: shmobile: koelsch: Enable SATA in defconfig
      ARM: shmobile: lager: Enable SATA in defconfig

 arch/arm/configs/ape6evm_defconfig         |  2 ++
 arch/arm/configs/armadillo800eva_defconfig |  2 ++
 arch/arm/configs/bockw_defconfig           |  2 ++
 arch/arm/configs/genmai_defconfig          |  2 ++
 arch/arm/configs/koelsch_defconfig         |  6 +++++-
 arch/arm/configs/kzm9d_defconfig           |  2 ++
 arch/arm/configs/kzm9g_defconfig           |  2 ++
 arch/arm/configs/lager_defconfig           | 13 +++++++++++++
 arch/arm/configs/mackerel_defconfig        |  2 ++
 arch/arm/configs/marzen_defconfig          |  2 ++
 10 files changed, 34 insertions(+), 1 deletion(-)
