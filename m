From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Aug 2014 09:23:58 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v3.18
Message-ID: <cover.1408492753.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v3.18.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v3.18

for you to fetch changes up to d594c9775409a4276133db5e34dbd791329c5eae:

  ARM: shmobile: lager: add VIN1/ADV7180 device nodes (2014-08-17 09:44:07 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v3.18

* Add VIN support to lager/r8a7790, koelsch/r8a7791 and henninger/r8a7791
* Enable DMA for MSIOF and QSPI on r8a7790 and r8a7791

----------------------------------------------------------------
Ben Dooks (2):
      ARM: shmobile: r8a7790: add VIN device nodes
      ARM: shmobile: lager: add VIN1/ADV7180 device nodes

Geert Uytterhoeven (4):
      ARM: shmobile: r8a7791 dtsi: Enable DMA for QSPI
      ARM: shmobile: r8a7791 dtsi: Enable DMA for MSIOF
      ARM: shmobile: r8a7790 dtsi: Enable DMA for QSPI
      ARM: shmobile: r8a7790 dtsi: Enable DMA for MSIOF

Laurent Pinchart (3):
      ARM: shmobile: r8a7790: Add DMAC clocks to DT
      ARM: shmobile: r8a7790: Add DMAC devices to DT
      ARM: shmobile: r8a7791: Add DMAC devices to DT

Sergei Shtylyov (2):
      ARM: shmobile: r8a7791: add VIN DT support
      ARM: shmobile: henninger: add VIN0/ADV7180 DT support

sergei.shtylyov at cogentembedded.com (1):
      ARM: shmobile: koelsch: add VIN1/ADV7180 DT support

 arch/arm/boot/dts/r8a7790-lager.dts     |  36 ++++++++++
 arch/arm/boot/dts/r8a7790.dtsi          | 120 ++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/r8a7791-henninger.dts |  35 ++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts   |  35 ++++++++++
 arch/arm/boot/dts/r8a7791.dtsi          | 101 ++++++++++++++++++++++++++-
 5 files changed, 318 insertions(+), 9 deletions(-)
