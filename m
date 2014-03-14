From: mporter@linaro.org (Matt Porter)
Date: Fri, 14 Mar 2014 15:40:55 -0400
Subject: ARM: mach-bcm: dt updates for 3.15 - part 2
Message-ID: <20140314194054.GA6134@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a33705ee8a8af40bbaa379e4567ca451c38fc0d6:

  ARM: dts: remove bcm11351-brt.dts (2014-03-05 01:28:56 -0500)

are available in the git repository at:

  git://github.com/broadcom/mach-bcm tags/armsoc/for-3.15/dt-2

for you to fetch changes up to a97d67d1c4c331644f26704976f92a5b160c3f77:

  ARM: dts: bcm28155-ap: leave camldo1 on to fix reboot (2014-03-14 12:22:39 -0400)

----------------------------------------------------------------
ARM: mach-bcm: dt updates for 3.15 - part 2

- BCM21664 SoC support
- BCM59056 PMU support
- BCM281xx reboot fix

----------------------------------------------------------------
Markus Mayer (2):
      ARM: DT: bcm21664: Device tree bindings
      ARM: dts: bcm21664: Add device tree files.

Matt Porter (2):
      ARM: dts: add bcm590xx pmu support and enable for bcm28155-ap
      ARM: dts: bcm28155-ap: leave camldo1 on to fix reboot

 .../devicetree/bindings/arm/bcm/bcm21664.txt       |  15 ++
 .../devicetree/bindings/arm/bcm/kona-resetmgr.txt  |  14 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/bcm21664-garnet.dts              |  56 ++++
 arch/arm/boot/dts/bcm21664.dtsi                    | 292 +++++++++++++++++++++
 arch/arm/boot/dts/bcm28155-ap.dts                  |  48 +++-
 arch/arm/boot/dts/bcm59056.dtsi                    |  74 ++++++
 7 files changed, 500 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm21664.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/kona-resetmgr.txt
 create mode 100644 arch/arm/boot/dts/bcm21664-garnet.dts
 create mode 100644 arch/arm/boot/dts/bcm21664.dtsi
 create mode 100644 arch/arm/boot/dts/bcm59056.dtsi
