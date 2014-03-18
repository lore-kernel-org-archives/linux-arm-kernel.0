From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Mar 2014 00:15:38 +0100
Subject: [PATCH 0/3] ARM: at91: improve at91sam9m10g45ek support
Message-ID: <1395184541-5787-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are a few DT improvements for the at91sam9m10g45ek.

The first patch corrects the ADC support for the at91sam9g45.

The second patch adds ADC and touchscreen support to the at91sam9m10g45ek.

The last one corrects the PWM polarity after the polarity got right in the
driver, following patch "PWM: atmel-pwm: Fix polarity handling"


Alexandre Belloni (3):
  ARM: at91/dt: sam9g45: improve ADC/touchscreen support
  ARM: at91/dt: at91sam9m10g45ek: add ADC and touchscreen support
  ARM: at91/dt: at91sam9m10g45ek PWM leds polarity is inversed

 arch/arm/boot/dts/at91sam9g45.dtsi     | 33 +++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 20 ++++++++++++++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

-- 
1.8.3.2
