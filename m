From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Apr 2014 09:32:08 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Fixes Updates for v3.15
Message-ID: <cover.1397694064.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM Based SoC Fixes Updates for v3.15.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v3.15

for you to fetch changes up to d5dda0381f826326071b027f288372f682c24d55:

  ARM: shmobile: koelsch: correct renesas,gpios to renesas,groups in sd[012] pfc (2014-04-15 07:39:11 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes Updates for v3.15

r8a7791 (R-Car M2) based koelsch board
* Correct renesas,gpios to renesas,groups in sd[012] pfc

8a7790 (R-Car H2) based lager board
* Correct SND_SOC_DAIFMT_CBx_CFx flags

r8a7740 (R-Mobile A1) SoC
* Drop address cells from GIC node

r8a7740 (R-Mobile A1) based Armadillo800 EVA board
* Correct SND_SOC_DAIFMT_CBx_CFx flags

sh73a0 (SH-Mobile AG5) SoC
* Drop address cells from GIC node

----------------------------------------------------------------
Kuninori Morimoto (2):
      ARM: shmobile: lager: fixup SND_SOC_DAIFMT_CBx_CFx flags
      ARM: shmobile: armadillo800eva: fixup SND_SOC_DAIFMT_CBx_CFx flags

Lucas Stach (2):
      ARM: shmobile: sh73a0: drop address cells from GIC node
      ARM: shmobile: r8a7740: drop address cells from GIC node

Magnus Damm (1):
      ARM: shmobile: koelsch: correct renesas,gpios to renesas,groups in sd[012] pfc

 arch/arm/boot/dts/r8a7740.dtsi                 | 1 -
 arch/arm/boot/dts/r8a7791-koelsch.dts          | 6 +++---
 arch/arm/boot/dts/sh73a0.dtsi                  | 1 -
 arch/arm/mach-shmobile/board-armadillo800eva.c | 1 +
 arch/arm/mach-shmobile/board-lager.c           | 4 +---
 5 files changed, 5 insertions(+), 8 deletions(-)
