From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 14 Jun 2016 20:57:10 +0200
Subject: [PATCH 0/2 v2] gpio-omap: ensure a stable gpio numbering
Message-ID: <1465930632-18941-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series' first patch is v2 of the patch I sent earlier. This now also
compiles without CONFIG_OF_GPIO.

The second patch is new and adds the respective aliases to all device trees
that make use of the gpio-omap driver.

Best regards
Uwe

Uwe Kleine-K?nig (2):
  gpio: omap: make gpio numbering deterministical by using of aliases
  ARM: dts: add aliases for ti,omap[234]-gpio devices

 arch/arm/boot/dts/am33xx.dtsi   |  4 ++++
 arch/arm/boot/dts/am4372.dtsi   |  6 ++++++
 arch/arm/boot/dts/dm814x.dtsi   |  2 ++
 arch/arm/boot/dts/dm816x.dtsi   |  2 ++
 arch/arm/boot/dts/dra7.dtsi     |  8 ++++++++
 arch/arm/boot/dts/omap2420.dtsi |  7 +++++++
 arch/arm/boot/dts/omap2430.dtsi |  8 ++++++++
 arch/arm/boot/dts/omap3.dtsi    |  6 ++++++
 arch/arm/boot/dts/omap4.dtsi    |  6 ++++++
 arch/arm/boot/dts/omap5.dtsi    |  8 ++++++++
 drivers/gpio/gpio-omap.c        | 19 ++++++++++++++++++-
 11 files changed, 75 insertions(+), 1 deletion(-)

-- 
2.8.1
