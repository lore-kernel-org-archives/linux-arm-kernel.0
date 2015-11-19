From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 19 Nov 2015 16:06:12 +0000
Subject: [PATCH RFC 0/4] ARM: bcm2835: assign pins to sdhci pinctrl
Message-ID: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes the pinctrl of the sdhci pins for all
Raspberry Pis.

The pin configuration based on the proprietary DTS [1].

[1] - https://www.raspberrypi.org/documentation/configuration/images/dt-blob.dts

Stefan Wahren (4):
  ARM: bcm2835: remove sdhci pins from GPIO pinctrl
  ARM: bcm2835: rename sdhci pin group
  ARM: bcm2835: specify card detect pin for RPi B
  ARM: bcm2835: assign pins to sdhci pinctrl

 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts |    6 +++++-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts |    6 +++++-
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts |    6 +++++-
 arch/arm/boot/dts/bcm2835-rpi-b.dts      |   11 ++++++++++-
 arch/arm/boot/dts/bcm2835-rpi.dtsi       |    2 +-
 5 files changed, 26 insertions(+), 5 deletions(-)

-- 
1.7.9.5
