From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 18 Sep 2015 15:35:35 +0800
Subject: [PATCH 0/4] ARM: dts: sun8i: Add pwm-backlight device for A23/A33 Q8
 format tablets
Message-ID: <1442561739-6824-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This series adds support for the PWM controlled backlight on the
A23/A33 Q8 tablets. The A23/A33 SoCs have the same PWM controller
as the A20, and the tablets use it to dim the LCD backlight.

The patches are pretty self-explaining.

Hans, could you test this on your TZX 723Q4? It's FEX file uses
a lower PWM frequency.


Regards
ChenYu


Chen-Yu Tsai (4):
  ARM: dts: sun8i: Add PWM controller node for A23/A33
  ARM: dts: sun8i: Add PWM channel 0 pinmux setting for A23/A33
  ARM: dts: sun8i: Enable PWM controller on A23/A33 Q8 format tablets
  ARM: dts: sun8i: Add pwm-backlight device for A23/A33 Q8 format
    tablets

 arch/arm/boot/dts/sun8i-a23-a33.dtsi   | 15 +++++++++++++++
 arch/arm/boot/dts/sun8i-q8-common.dtsi | 26 ++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

-- 
2.5.1
