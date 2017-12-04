From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 4 Dec 2017 14:00:15 +0800
Subject: [PATCH 0/3] pwm: meson-axg: add pwm controller driver
Message-ID: <20171204060018.8856-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series try to add PWM controller driver for the 
Amlogic's Meson-AXG SoC. Update the Clock sources, pin DT.

Jian Hu (3):
  dt-bindings: pwm: update bindings for the Meson-AXG
  pwm: meson: add clock source configuratin for Meson-AXG
  ARM64: dts: meson-axg: add PWM DT info for Meson-Axg SoC

 .../devicetree/bindings/pwm/pwm-meson.txt          |   2 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         | 120 +++++++++++++++++++++
 drivers/pwm/pwm-meson.c                            |  26 +++++
 3 files changed, 148 insertions(+)

-- 
2.15.0
