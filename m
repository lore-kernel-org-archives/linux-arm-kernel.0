From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:33 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v4.7
Message-ID: <cover.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC cleanup for v4.7.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v4.7

for you to fetch changes up to 000025cfbb9e8bafd0a1fa84d8d83526d24bde42:

  ARM: dts: sh73a0: Remove unnecessary clock-output-names properties (2016-03-28 08:56:11 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Cleanup for v4.7

* Remove unnecessary clock-output-names properties from DT
* Use generic pinctrl properties in DT

----------------------------------------------------------------
Simon Horman (26):
      ARM: dts: lager: use generic pinctrl properties
      ARM: dts: ape6evm: use generic pinctrl properties
      ARM: dts: armadillo800eva: use generic pinctrl properties
      ARM: dts: bockw: use generic pinctrl properties
      ARM: dts: marzen: use generic pinctrl properties
      ARM: dts: koelsch: use generic pinctrl properties
      ARM: dts: porter: use generic pinctrl properties
      ARM: dts: gose: use generic pinctrl properties
      ARM: dts: alt: use generic pinctrl properties
      ARM: dts: silk: use generic pinctrl properties
      ARM: dts: kzm9g: use generic pinctrl properties
      ARM: dts: kzm9d: use generic pinctrl properties
      ARM: dts: r8a7790: Remove unnecessary clock-output-names properties
      ARM: dts: r7s72100: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7740: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7778: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7779: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7791: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7793: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7794: Remove unnecessary clock-output-names properties
      ARM: dts: gose: Remove unnecessary clock-output-names properties
      ARM: dts: koelsch: Remove unnecessary clock-output-names properties
      ARM: dts: porter: Remove unnecessary clock-output-names properties
      ARM: dts: lager: Remove unnecessary clock-output-names properties
      ARM: dts: r8a73a4: Remove unnecessary clock-output-names properties
      ARM: dts: sh73a0: Remove unnecessary clock-output-names properties

 arch/arm/boot/dts/emev2-kzm9d.dts             |  4 +-
 arch/arm/boot/dts/r7s72100.dtsi               | 15 ++---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts         | 20 +++---
 arch/arm/boot/dts/r8a73a4.dtsi                | 75 +++++++--------------
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 34 +++++-----
 arch/arm/boot/dts/r8a7740.dtsi                | 57 ++++++----------
 arch/arm/boot/dts/r8a7778-bockw.dts           | 40 +++++------
 arch/arm/boot/dts/r8a7778.dtsi                | 21 ++----
 arch/arm/boot/dts/r8a7779-marzen.dts          | 36 +++++-----
 arch/arm/boot/dts/r8a7779.dtsi                | 15 ++---
 arch/arm/boot/dts/r8a7790-lager.dts           | 95 +++++++++++++--------------
 arch/arm/boot/dts/r8a7790.dtsi                | 88 ++++++++-----------------
 arch/arm/boot/dts/r8a7791-koelsch.dts         | 71 ++++++++++----------
 arch/arm/boot/dts/r8a7791-porter.dts          | 63 +++++++++---------
 arch/arm/boot/dts/r8a7791.dtsi                | 79 +++++++---------------
 arch/arm/boot/dts/r8a7793-gose.dts            | 43 ++++++------
 arch/arm/boot/dts/r8a7793.dtsi                | 45 ++++---------
 arch/arm/boot/dts/r8a7794-alt.dts             | 32 ++++-----
 arch/arm/boot/dts/r8a7794-silk.dts            | 44 ++++++-------
 arch/arm/boot/dts/r8a7794.dtsi                | 66 +++++++------------
 arch/arm/boot/dts/sh73a0-kzm9g.dts            | 30 ++++-----
 arch/arm/boot/dts/sh73a0.dtsi                 | 87 ++++++++----------------
 22 files changed, 432 insertions(+), 628 deletions(-)
