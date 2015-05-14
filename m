From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:07:16 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.2
Message-ID: <cover.1431565572.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.2.


The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.2

for you to fetch changes up to 90037558d5ed25a63499c3973cc1af25da02f673:

  ARM: shmobile: defconfig: Replace USB_RCAR_GEN2_PHY by PHY_RCAR_GEN2 (2015-05-01 21:25:43 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.2

* Replace legacy-only USB_RCAR_GEN2_PHY with DT-only PHY_RCAR_GEN2

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: defconfig: Replace USB_RCAR_GEN2_PHY by PHY_RCAR_GEN2

 arch/arm/configs/shmobile_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
