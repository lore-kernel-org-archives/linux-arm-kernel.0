From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Thu, 16 Apr 2015 19:19:14 +0200
Subject: [PATCH v4 0/2] ARM: at91/dt: add support for at91-kizboxmini
Message-ID: <1429204756-26749-1-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are two patches to bring support for a new hardware based on SAM9G25 SoC.

The first one adds the PIN controller definition for PWM0.
The second defines the new board.

Changes since v1:
- drop useless comments
- move pwm0 pinctrl's node close to tcb0
- drop ek boards from compatible machine
- add at91sam9g25 board to compatible machine

Changes since v2:
- update to v4.0
- fix alphabetical order between gpio_keys and pwm_leds

Changes since v3:
- add num-ports = <1> attribute to ohci node

PS: My apologies for this last minute update.

Ga?l PORTAY (2):
  ARM: at91/dt: sam9x5: add pinctrl for pwm0
  ARM: at91/dt: add support for kizboxmini

 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/at91-kizboxmini.dts | 130 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi     |  46 ++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini.dts

-- 
1.9.3
