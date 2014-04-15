From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 15 Apr 2014 13:07:41 +0200
Subject: [PATCH 0/2] Add more peripherals to the sam9rlek
Message-ID: <1397560063-7439-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, this patch set adds support for SPI, LCD, i2c, ADC and touchscreen, USB
gadget and PWM on the at91sam9rlek.

The only missing piece is now audio/ac97 support, then the SoC will be entirely
supported using DT.

Alexandre Belloni (2):
  ARM: at91/dt: sam9rl: add lcd, adc, usb gadget and pwm support
  ARM: at91/dt: add peripherals to the at91sam9rlek board

 arch/arm/boot/dts/at91sam9rl.dtsi  | 265 +++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/at91sam9rlek.dts |  90 ++++++++++++-
 2 files changed, 342 insertions(+), 13 deletions(-)

-- 
1.8.3.2
