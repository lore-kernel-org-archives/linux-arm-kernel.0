From: lee@kernel.org (Lee Jones)
Date: Tue, 11 Aug 2015 17:06:42 +0100
Subject: [GIT PULL] RPi DT changes due for v4.3
Message-ID: <20150811160642.GQ18282@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM SoC Chaps,

Please find a couple of simple RPi changes pertaining to Firmware.

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git tags/rpi-dt-for-armsoc-4.3

for you to fetch changes up to fd26f8830979de48eb3f1c253eb9d2ee2e468eb6:

  dt/bindings: Add binding for the Raspberry Pi firmware driver (2015-08-11 16:56:41 +0100)

----------------------------------------------------------------
 - New Firmware node and accompanying binding document

----------------------------------------------------------------
Eric Anholt (2):
      ARM: bcm2835: Add the firmware driver information to the RPi DT
      dt/bindings: Add binding for the Raspberry Pi firmware driver

 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt | 14 ++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                                         |  7 +++++++
 2 files changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
