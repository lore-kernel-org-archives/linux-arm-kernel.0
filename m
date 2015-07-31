From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 31 Jul 2015 17:08:07 +0200
Subject: [RFC PATCH 0/3] New Atmel PIO4 pinctrl/gpio driver
Message-ID: <1438355290-28255-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Following our discussion, I send an RFC version of my driver. RFC because it is
not totally achieved, some cleanup and feature addition is needed.

At least, we could discuss about the 'core' part. I have used the pinmux
property as Mediatek driver. Patch 3 is the internal dt files we are using.

Thanks for your reviews.

Ludovic Desroches (3):
  pinctrl: introduce driver for Atmel PIO4 controller
  ARM: at91/dt: add sama5d2 pinmux
  ARM: at91/dt: add pinctrl

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  386 ++++++++++
 arch/arm/boot/dts/sama5d2-pinfunc.h         |  760 +++++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi              | 1076 +++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-at91-pio4.c         |  959 ++++++++++++++++++++++++
 4 files changed, 3181 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d2_xplained.dts
 create mode 100644 arch/arm/boot/dts/sama5d2-pinfunc.h
 create mode 100644 arch/arm/boot/dts/sama5d2.dtsi
 create mode 100644 drivers/pinctrl/pinctrl-at91-pio4.c

-- 
2.5.0
