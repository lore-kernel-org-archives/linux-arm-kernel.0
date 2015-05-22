From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 22 May 2015 12:21:40 +0100
Subject: [GIT PULL] arm64: Juno DT updates
Message-ID: <20150522112140.GU2175@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

The DT updates for Juno and Juno r1 are ready to be pulled at your earliest convenience.

Many thanks,
Liviu


The following changes since commit c0655fe9b0901a968800f56687be3c62b4cce5d2:

  Merge tag 'usb-4.1-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2015-05-16 21:15:59 -0700)

are available in the git repository at:

  git://linux-arm.org/linux-ld for-upstream/juno-dts

for you to fetch changes up to 8f821c9b8ec0e82ebd10ae12a267e4397cc53566:

  Documentation: bindings: Add DT bindings for ARM Juno boards. (2015-05-22 11:51:08 +0100)

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
