From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 13 May 2017 20:35:25 -0700
Subject: [GIT PULL 1/2] Broadcom devicetree changes for 4.12
Message-ID: <20170514033526.21260-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/devicetree-fixes

for you to fetch changes up to b155f05dc578299557447a6fd6545ebc72c1d19b:

  Merge tag 'bcm2835-dt-next-2017-03-30' into devicetree/fixes (2017-05-13 20:26:09 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC Device Tree fixes for
4.12, please pull the following:

- Baruch provides several fixes for the Raspberry Pi (BCM2835) Device
  Tree source include file: uart0 pinctrl node names, pin number for
  i2c0, uart0 rts/cts pins and invalid uart1 pin, missing numbers for
  ethernet aliases

----------------------------------------------------------------
Baruch Siach (4):
      ARM: dts: bcm2835: fix uart0 pinctrl node names
      ARM: dts: bcm2835: fix i2c0 pins
      ARM: dts: bcm2835: fix uart0/uart1 pins
      ARM: dts: bcm2835: add index to the ethernet alias

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2017-03-30' into devicetree/fixes

 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi |  2 +-
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi |  2 +-
 arch/arm/boot/dts/bcm283x.dtsi              | 22 +++++++++++++---------
 3 files changed, 15 insertions(+), 11 deletions(-)
