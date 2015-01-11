From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 11 Jan 2015 22:51:40 +0800
Subject: [GIT PULL] CSR atlas7 init dts for 3.20
Message-ID: <CAGsJ_4wBEmLa8t-bVBQTBhJDHSU=-ciycpAnH4arWPNUq-tHWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

The following changes since commit b7392d2247cfe6771f95d256374f1a8e6a6f48d6:

  Linux 3.19-rc2 (2014-12-28 16:49:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

for you to fetch changes up to e57574b88f1d29de0b0e9a3a994cd60c8b800253:

  ARM: dts: add init dts file for CSR atlas7 SoC (2015-01-11 22:39:10 +0800)

----------------------------------------------------------------
drop marco and add init dts for atlas7

marco chip has been dropped and the new replacement is atlas7.
so, drop marco dts, and add dts for atlas7.

----------------------------------------------------------------
Barry Song (1):
      ARM: dts: drop MARCO platform DT stuff

Zhiwu Song (1):
      ARM: dts: add init dts file for CSR atlas7 SoC

 Documentation/devicetree/bindings/arm/sirf.txt |    2 -
 arch/arm/boot/dts/Makefile                     |    2 +-
 arch/arm/boot/dts/atlas7-evb.dts               |  110 ++++
 arch/arm/boot/dts/atlas7.dtsi                  |  813 ++++++++++++++++++++++++
 arch/arm/boot/dts/marco-evb.dts                |   54 --
 arch/arm/boot/dts/marco.dtsi                   |  757 ----------------------
 6 files changed, 924 insertions(+), 814 deletions(-)
 create mode 100644 arch/arm/boot/dts/atlas7-evb.dts
 create mode 100644 arch/arm/boot/dts/atlas7.dtsi
 delete mode 100644 arch/arm/boot/dts/marco-evb.dts
 delete mode 100644 arch/arm/boot/dts/marco.dtsi

-barry
