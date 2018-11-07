From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Nov 2018 12:25:04 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.20
Message-ID: <cover.1541514075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.20.


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.20

for you to fetch changes up to eab53fdfd60a84b0cc514d4f1f5d79226c76df01:

  arm64: dts: renesas: condor: switch from EtherAVB to GEther (2018-11-05 15:08:44 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.20

* R-Car V3H (r8a77980) based Condor board
  - Switch from EtherAVB to GEther to match offical boards

* RZ/G2E (ra8774c0) SoC: correct documentation of part number

* R-Car H3 (r8a7795) SoC: reinstate all DMA channels on HSCIF2

----------------------------------------------------------------
Fabrizio Castro (1):
      dt-bindings: arm: Fix RZ/G2E part number

Kuninori Morimoto (1):
      arm64: dts: renesas: r8a7795: add missing dma-names on hscif2

Sergei Shtylyov (1):
      arm64: dts: renesas: condor: switch from EtherAVB to GEther

 Documentation/devicetree/bindings/arm/shmobile.txt |  2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  2 +-
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts    | 47 +++++++++++-----------
 3 files changed, 26 insertions(+), 25 deletions(-)
