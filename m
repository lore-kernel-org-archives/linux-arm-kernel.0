From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 21 Nov 2012 12:20:56 +0100
Subject: [PATCH] pwm support for newer i.MX
Message-ID: <1353496859-29164-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following adds/completes the device nodes for the PWM found
on i.MX5/6. It is based on Fabios patch converting the clock lookups
for i.MX5 to devicetree.

Sascha

----------------------------------------------------------------
Sascha Hauer (3):
      ARM i.MX53: Add pwm support
      ARM i.MX51: Add pwm support
      ARM i.MX6: Add pwm support

 arch/arm/boot/dts/imx51.dtsi |   18 ++++++++++++++++++
 arch/arm/boot/dts/imx53.dtsi |   18 ++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi |   16 ++++++++++++++++
 3 files changed, 52 insertions(+)
