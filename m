From: eric@anholt.net (Eric Anholt)
Date: Tue, 27 Nov 2018 13:13:01 -0800
Subject: [GIT PULL 4/4] bcm2835-dt-next-2018-11-27
In-Reply-To: <20181127211301.30296-1-eric@anholt.net>
References: <20181127211301.30296-1-eric@anholt.net>
Message-ID: <20181127211301.30296-4-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2018-11-27

for you to fetch changes up to 703c605fac82d580822dc39f5eff9e2fe66ed63d:

  ARM: dts: bcm2835-rpi-zero: Switch to SPDX identifier (2018-11-13 19:32:28 +0100)

----------------------------------------------------------------
This pull request adds a compatible string to the DT necessary for the
firmware and VCHI driver to coordinate on using the correct cache line
size for the platform.

----------------------------------------------------------------
Phil Elwell (3):
      dt-bindings: soc: Document "brcm,bcm2836-vchiq"
      ARM: dts: bcm283x: Correct vchiq compatible string
      ARM: dts: bcm283x: Correct mailbox register sizes

Stefan Wahren (1):
      ARM: dts: bcm2835-rpi-zero: Switch to SPDX identifier

 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt | 3 ++-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts                         | 8 +-------
 arch/arm/boot/dts/bcm2835-rpi-zero.dts                           | 8 +-------
 arch/arm/boot/dts/bcm2835-rpi.dtsi                               | 4 ++--
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts                            | 2 +-
 arch/arm/boot/dts/bcm2836-rpi.dtsi                               | 6 ++++++
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts                       | 2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts                            | 2 +-
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi                           | 2 +-
 9 files changed, 16 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2836-rpi.dtsi
