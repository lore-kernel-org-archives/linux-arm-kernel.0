From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:38:36 +0900
Subject: [GIT PULL 0/4] Renesas ARM based SoC defconfig updates for v3.13
Message-ID: <cover.1380514316.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof and Arnd,

please consider these Renesas ARM based SoC defconfig updates for v3.13.

This pull request is based on v3.12-rc1.


As I discussed with Olof recently, we are making solid progress towards
multi-platform with common-clocks being the last major hurdle. I do expect
to be able to start booting some shmobile boards using multi-platform
within the next few release cycles. However, we are not there yet and in
the mean time I would like to keep the defconfigs in good shape.


The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.13

for you to fetch changes up to 6bb2e347899b297eea26f2658eac8fdcd633fba5:

  ARM: shmobile: Add koelsch defconfig (2013-09-20 17:46:15 -0700)

----------------------------------------------------------------
Renesas ARM based SoC defconfig updates for v3.13

* Add defconfig for koelsch board
* Enable sound in defconfig for bockw board
* Enable R-Car DU DRM in defconfig for lager and marzen boards

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: bockw defconfig: add Sound support

Laurent Pinchart (2):
      ARM: shmobile: marzen: Select DRM_RCAR_DU in defconfig
      ARM: shmobile: lager: Select DRM_RCAR_DU in defconfig

Simon Horman (1):
      ARM: shmobile: Add koelsch defconfig

 arch/arm/configs/bockw_defconfig   |  4 +++
 arch/arm/configs/koelsch_defconfig | 54 ++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/lager_defconfig   |  2 ++
 arch/arm/configs/marzen_defconfig  |  2 ++
 4 files changed, 62 insertions(+)
 create mode 100644 arch/arm/configs/koelsch_defconfig
