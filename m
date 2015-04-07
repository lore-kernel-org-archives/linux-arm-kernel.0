From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Tue,  7 Apr 2015 16:11:22 +0200
Subject: [PATCH 0/2] ARM: at91/dt: add support for at91-kizboxmini
Message-ID: <1428415884-30662-1-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are two patches to bring support for a new hardware based on SAM9G25 SoC.

The first one adds the PIN controller definition for PWM0.
The second defines the new board.

Best regards,
Ga?l PORTAY (2):
  ARM: at91/dt: sam9x5: add pinctrl for pwm0
  ARM: at91/dt: add support for kizboxmini.

 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/at91-kizboxmini.dts | 129 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi     |  46 ++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini.dts

-- 
1.9.1
