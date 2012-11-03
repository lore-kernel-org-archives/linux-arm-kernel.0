From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  3 Nov 2012 16:59:06 +0100
Subject: [PATCH 0/2] Pinctrl muxing for the Crystalfontz boards
Message-ID: <1351958348-7327-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch serie add the hogpins to explicitly mux the GPIOs used
across the device tree as such for the two Crystalfontz boards, and
make the gpio-led driver use pinctrl.

This serie goes on top of the i2c-mux-gpios patches I sent on this
list.

Maxime

Maxime Ripard (2):
  ARM: dts: cfa10036: Use pinctrl for power led
  ARM: dts: mxs: Add hog pins to Crystalfontz boards

 arch/arm/boot/dts/imx28-cfa10036.dts |   27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-cfa10049.dts |   16 ++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
1.7.9.5
