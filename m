From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Mon, 19 Sep 2016 19:53:44 +0530
Subject: [PATCH 0/3] iMX7 PWM polarity control
Message-ID: <20160919142347.11342-1-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset depends on this patchset[1] and this patch[2] which adds support
for polarity control in imx-pwm driver.

- Use pwm polarity control on iMX7 based modules.
- Enable polarity control on Toradex Colibri iMX7D/S module.
- Add BL_ON GPIO control for Toradex Colibri iMX7D/S module.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/294027.html
[2] https://www.spinics.net/lists/arm-kernel/msg530818.html

Bhuvanchandra DV (3):
  arm: dts: imx7: Update #pwm-cells for PWM polarity control
  arm: dts: imx7-colibri: Use pwm polarity control
  arm: dts: imx7-colibri: Use enable-gpios for BL_ON

 Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +++---
 arch/arm/boot/dts/imx7-colibri.dtsi               | 12 ++++++++++--
 arch/arm/boot/dts/imx7s.dtsi                      |  8 ++++----
 3 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.9.2
