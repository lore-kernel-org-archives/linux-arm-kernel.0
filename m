From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:48 -0800
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.5
Message-ID: <cover.1447980335.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.5.


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.5

for you to fetch changes up to b138e11931f2fe25cf188ed62b54bc36f59a25ce:

  MAINTAINERS: Add entry for Renesas arm64 architecture (2015-11-17 02:55:03 +0900)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.5

* Initial support for Renesas ARM64 Based r8a7795 SoC and
  Salvator-X board

----------------------------------------------------------------
Geert Uytterhoeven (2):
      arm64: renesas: r8a7795: Add dummy dma-controller nodes
      arm64: renesas: r8a7795: Add all SCIF nodes

Kuninori Morimoto (2):
      arm64: renesas: r8a7795: enable PFC
      arm64: renesas: add Salvator-X board support

Simon Horman (2):
      arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
      MAINTAINERS: Add entry for Renesas arm64 architecture

 Documentation/devicetree/bindings/arm/shmobile.txt |   4 +
 MAINTAINERS                                        |   9 ++
 arch/arm64/Kconfig.platforms                       |  17 ++
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/renesas/Makefile               |   4 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  62 ++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 173 +++++++++++++++++++++
 7 files changed, 270 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/Makefile
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795.dtsi
