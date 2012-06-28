From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:44:56 +0800
Subject: [PATCH 00/11] mxs dts updates
Message-ID: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series makes a bunch of mxs dts updates to provide an equivalent
device tree support of imx23-evk and imx28-evk board files which are
meant to be removed completely soon.

Shawn Guo (11):
  ARM: dts: mxs: add comments for pinmux-ids
  ARM: dts: mxs: add hog-gpios for imx23-evk and imx28-evk
  ARM: dts: imx23-evk: updates for mmc device
  ARM: dts: imx23-evk: add auart device
  ARM: dts: imx28-evk: add vmmc-supply for mmc device
  ARM: dts: imx28-evk: add missing properties for fec
  ARM: dts: imx28-evk: add flexan devices
  ARM: dts: imx28-evk: add heartbeat gpio-leds
  ARM: dts: mxs: enable rtc for imx23 and imx28
  ARM: dts: mxs: add pwm-backlight for imx23-evk and imx28-evk
  ARM: dts: mxs: add lcd support for imx23-evk and imx28-evk

 arch/arm/boot/dts/imx23-evk.dts |   60 +++++++++++-
 arch/arm/boot/dts/imx23.dtsi    |  118 ++++++++++++++++++++--
 arch/arm/boot/dts/imx28-evk.dts |   83 +++++++++++++++
 arch/arm/boot/dts/imx28.dtsi    |  211 +++++++++++++++++++++++++++++++++------
 4 files changed, 434 insertions(+), 38 deletions(-)

-- 
1.7.5.4
