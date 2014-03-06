From: mporter@linaro.org (Matt Porter)
Date: Thu, 6 Mar 2014 01:36:05 -0500
Subject: ARM: mach-bcm dt updates for 3.15
Message-ID: <20140306063605.GA30045@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://github.com/broadcom/mach-bcm tags/armsoc/for-3.15/dt

for you to fetch changes up to a33705ee8a8af40bbaa379e4567ca451c38fc0d6:

  ARM: dts: remove bcm11351-brt.dts (2014-03-05 01:28:56 -0500)

----------------------------------------------------------------
ARM: mach-bcm dt updates for 3.15

- add BCM4708 dt support
- remove bcm11351-brt
- bcm281xx common clock support

----------------------------------------------------------------
Alex Elder (1):
      ARM: dts: bcm281xx: define real clocks

Hauke Mehrtens (1):
      ARM: BCM5301X: add dts files for BCM4708 SoC

Matt Porter (1):
      ARM: dts: remove bcm11351-brt.dts

Tim Kryger (1):
      ARM: dts: Leave sdio1 as disabled on bcm28155-ap

 arch/arm/boot/dts/Makefile                  |   4 +-
 arch/arm/boot/dts/bcm11351-brt.dts          |  54 --------
 arch/arm/boot/dts/bcm11351.dtsi             | 192 ++++++++++++++++++++--------
 arch/arm/boot/dts/bcm28155-ap.dts           |   5 -
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts |  35 +++++
 arch/arm/boot/dts/bcm4708.dtsi              |  34 +++++
 arch/arm/boot/dts/bcm5301x.dtsi             |  95 ++++++++++++++
 7 files changed, 306 insertions(+), 113 deletions(-)
 delete mode 100644 arch/arm/boot/dts/bcm11351-brt.dts
 create mode 100644 arch/arm/boot/dts/bcm4708-netgear-r6250.dts
 create mode 100644 arch/arm/boot/dts/bcm4708.dtsi
 create mode 100644 arch/arm/boot/dts/bcm5301x.dtsi
