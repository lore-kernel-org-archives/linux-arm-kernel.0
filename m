From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Aug 2015 11:11:31 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC DT Updates for v4.3
Message-ID: <cover.1438911334.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC DT updates for v4.3.

This pull request is based on the previous round of
such requests, tagged as renesas-dt2-for-v4.3,
which I have already sent a pull-request for.


The following changes since commit 7fd6e11dca09b21efbe2b9db4eff08c8f4a16125:

  ARM: shmobile: r8a7791: Add Audio MIX support on DTSI (2015-07-22 09:36:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v4.3

for you to fetch changes up to 94bdc48d55ca10f90b4a625f0e443197e0013557:

  ARM: shmobile: sh73a0 dtsi: Add missing "gpio-ranges" to gpio node (2015-08-05 06:39:28 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC DT Updates for v4.3

* Add JPU support: r8a7791 and r8a7790 SoCs
* Add MMCIF and PFC support: r8a7794 SoC
* Add initial support for r8a7794/silk
* Add missing "gpio-ranges" to gpio nodes: sh73a0, r8a7740 and r8a73a4 SoCs

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: r8a73a4 dtsi: Add missing "gpio-ranges" to gpio node
      ARM: shmobile: r8a7740 dtsi: Add missing "gpio-ranges" to gpio node
      ARM: shmobile: sh73a0 dtsi: Add missing "gpio-ranges" to gpio node

Mikhail Ulyanov (2):
      ARM: shmobile: r8a7790: Add JPU device node.
      ARM: shmobile: r8a7791: Add JPU device node.

Sergei Shtylyov (5):
      ARM: shmobile: r8a7794: add PFC DT support
      ARM: shmobile: silk: initial device tree
      ARM: shmobile: silk: add Ether DT support
      ARM: shmobile: r8a7794: add MMCIF DT support
      ARM: shmobile: silk: add eMMC DT support

 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/r8a73a4.dtsi     |   7 +++
 arch/arm/boot/dts/r8a7740.dtsi     |   1 +
 arch/arm/boot/dts/r8a7790.dtsi     |   7 +++
 arch/arm/boot/dts/r8a7791.dtsi     |   7 +++
 arch/arm/boot/dts/r8a7794-silk.dts | 102 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7794.dtsi     |  17 +++++++
 arch/arm/boot/dts/sh73a0.dtsi      |   3 ++
 8 files changed, 145 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7794-silk.dts
