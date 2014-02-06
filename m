From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  6 Feb 2014 10:40:30 +0100
Subject: [PATCH v2 0/2] clocksource: sunxi: Change compatibles pattern
Message-ID: <1391679632-15139-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the second version of the clocksource compatible changes.
The only difference with the v1 being that we're now droping the old
compatibles, instead of keeping them, since the DT maintainers said it was
fine.

Thanks,
Maxime

Maxime Ripard (2):
  clocksource: sunxi: Add new compatibles
  ARM: sunxi: dt: Convert to the new clocksource compatible

 Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt | 4 ++--
 arch/arm/boot/dts/sun4i-a10.dtsi                                  | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                                 | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                                  | 2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                                  | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                                  | 2 +-
 drivers/clocksource/sun4i_timer.c                                 | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.8.4.2
