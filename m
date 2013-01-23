From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Wed, 23 Jan 2013 18:56:50 +0100
Subject: [PATCH 0/2] ARM: dts: omap3-overo: Add pwm-leds and audio support
Message-ID: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Benoit,

This patchset adds some new DT supports to the Overo products.
The first patch converts the PMIC LEDB output to use the pwm-leds,
newly merged in your branch for_3.9/dts. The second patch
adds the audio support.

Best regards,

Florian

Florian Vaussard (2):
  ARM: dts: omap3-overo: Add support for pwm-leds
  ARM: dts: omap3-overo: Add audio support

 arch/arm/boot/dts/omap3-overo.dtsi |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

-- 
1.7.5.4
