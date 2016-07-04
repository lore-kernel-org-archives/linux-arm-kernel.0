From: eric@anholt.net (Eric Anholt)
Date: Sun,  3 Jul 2016 17:45:35 -0700
Subject: [GIT PULL 2/3] bcm2835-dt-64-next-2016-07-03
In-Reply-To: <1467593136-29524-1-git-send-email-eric@anholt.net>
References: <1467593136-29524-1-git-send-email-eric@anholt.net>
Message-ID: <1467593136-29524-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  https://github.com/anholt/linux tags/bcm2835-dt-64-next-2016-07-03

for you to fetch changes up to 02d08603649816a941246c18252e5c41fd07625a:

  ARM: bcm2837: dt: Add the ethernet to the device trees (2016-06-07 15:23:08 -0700)

----------------------------------------------------------------
This pull request brings in the Raspberry Pi 3 DT for its arm64
support.  Note that it also merges in the ethernet DT changes so that
the Pi3's ethernet can also get the MAC address.

----------------------------------------------------------------
Eric Anholt (3):
      dt-bindings: Add root properties for Raspberry Pi 3
      ARM: bcm2835: Add devicetree for the Raspberry Pi 3.
      Merge tag 'bcm2835-dt-ethernet' into HEAD

Gerd Hoffmann (1):
      ARM: bcm2837: dt: Add the ethernet to the device trees

Lubomir Rintel (1):
      ARM: bcm2835: dt: Add the ethernet to the device trees

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  1 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  1 +
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi        | 19 ++++++
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi        | 19 ++++++
 arch/arm/boot/dts/bcm283x.dtsi                     |  2 +
 arch/arm64/boot/dts/broadcom/Makefile              |  1 +
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   | 30 +++++++++
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi          | 76 ++++++++++++++++++++++
 11 files changed, 155 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837.dtsi
