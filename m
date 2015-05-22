From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 22 May 2015 16:30:03 +0100
Subject: [GIT PULL] arm64: Juno DT updates (rebased on v4.1-rc1)
Message-ID: <20150522153003.GX2175@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

(Take 2: rebased on top of v4.1-rc1.)

The DT updates for Juno and Juno r1 are ready to be pulled at your earliest convenience.

Many thanks,
Liviu


The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://linux-arm.org/linux-ld for-upstream/juno-dts

for you to fetch changes up to 41e177b37bd558980d50609116f7810b46fe4ce0:

  Documentation: bindings: Add DT bindings for ARM Juno boards. (2015-05-22 16:25:40 +0100)

----------------------------------------------------------------
Liviu Dudau (6):
      arm64: Juno: Fix the GIC node address label and the frequency of FAXI clock.
      arm64: Juno: Split juno.dts into juno-base.dtsi and juno.dts.
      arm64: Juno: Add memory mapped timer node
      arm64: Juno: Add GICv2m support in device tree.
      arm64: Add DT support for Juno r1 board.
      Documentation: bindings: Add DT bindings for ARM Juno boards.

 Documentation/devicetree/bindings/arm/arm-boards |  66 ++++++++++
 arch/arm64/boot/dts/arm/Makefile                 |   2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi           | 154 +++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-clocks.dtsi         |   4 +-
 arch/arm64/boot/dts/arm/juno-r1.dts              | 116 +++++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts                 | 129 +------------------
 6 files changed, 340 insertions(+), 131 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/juno-base.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/juno-r1.dts

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
