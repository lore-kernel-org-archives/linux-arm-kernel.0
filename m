From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Feb 2014 22:14:13 +0100
Subject: [PATCH v2 0/2] rtc: sunxi: Change compatible patterns
Message-ID: <1391807655-29169-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the second version of the A10 RTC compatible changes.
The only difference with the v1 being that we're now droping the old
compatibles, instead of keeping them, since the DT maintainers said it was
fine.

Thanks,
Maxime

Maxime Ripard (2):
  rtc: sunxi: Change compatibles
  ARM: sunxi: dt: Convert to the new RTC compatibles

 Documentation/devicetree/bindings/rtc/sunxi-rtc.txt | 4 ++--
 arch/arm/boot/dts/sun4i-a10.dtsi                    | 2 +-
 drivers/rtc/rtc-sunxi.c                             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.4.2
