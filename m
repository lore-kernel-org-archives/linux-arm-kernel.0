From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:50 +0900
Subject: [GIT PULL 00/17] Renesas ARM Based SoC DT Updates for v3.15
Message-ID: <cover.1391665761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider these Renesas ARM Based SoC DT updates for v3.15.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v3.15

for you to fetch changes up to 1f4c745b2c5a083c49dc11d2f0827d9a381f1ee1:

  ARM: shmobile: r8a7790: Replace IRQ type numerical values with macros (2014-02-04 10:17:00 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v3.15

* r8a7791 (R-Car M2) based Koelsch board
  - Enable GPIO Keys, (1+1)GiB memory, SATA0 and serial ports
  - Add VIN and thermal clocks
  - Remove r8a7791-koelsch-reference.dts

* r8a7790 (R-Car H2) based Lager board
  - Replace IRQ type numerical values with macros
  - Enable SATA0 and serial ports
  - Add VIN and thermal clocks

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: r8a7791: Add thermal clock in device tree
      ARM: shmobile: r8a7790: Add thermal clock in device tree

Laurent Pinchart (10):
      ARM: shmobile: dts: Remove r8a7791-koelsch-reference.dts
      ARM: shmobile: Add GPIO keys to Koelsch DTS
      ARM: shmobile: r8a7791: Add serial ports to the device tree
      ARM: shmobile: r8a7790: Add serial ports to the device tree
      ARM: shmobile: r8a7790: Add VIN clocks to device tree
      ARM: shmobile: r8a7791: Add VIN clocks to device tree
      ARM: shmobile: r8a7790: Add SATA clocks to device tree
      ARM: shmobile: r8a7791: Add SATA clocks to device tree
      ARM: shmobile: r8a7790: Fix serial ports DT compatible strings
      ARM: shmobile: r8a7790: Replace IRQ type numerical values with macros

Takashi Yoshii (1):
      ARM: shmobile: koelsch: (1+1)GiB memory in DT

Valentine Barshak (4):
      ARM: shmobile: r8a7791: Add SATA nodes to r8a7791.dtsi
      ARM: shmobile: koelsch: Enable SATA0 in r8a7791-koelsch.dts
      ARM: shmobile: r8a7790: Add SATA nodes to r8a7790.dtsi
      ARM: shmobile: lager: Enable SATA1 in r8a7790-lager.dts

 arch/arm/boot/dts/r8a7790-lager.dts             |   4 +
 arch/arm/boot/dts/r8a7790.dtsi                  | 131 ++++++++++++++-
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts | 115 -------------
 arch/arm/boot/dts/r8a7791-koelsch.dts           |  65 +++++++-
 arch/arm/boot/dts/r8a7791.dtsi                  | 210 +++++++++++++++++++++++-
 5 files changed, 403 insertions(+), 122 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7791-koelsch-reference.dts
