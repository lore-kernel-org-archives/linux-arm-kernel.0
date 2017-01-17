From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 17 Jan 2017 13:05:36 +0100
Subject: [PATCH 0/2] pinctrl: meson-gx: Add HDMI HDP/DDC pins functions
Message-ID: <1484654738-5496-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support HDMI HPD and DDC, add missing functions in pinctrl
driver and add corresponding nodes in dts for GXBB and GXL.

Neil Armstrong (2):
  pinctrl: meson: Add HDMI HPD/DDC pins functions
  ARM64: dts: meson-gx: Add HDMI HPD/DDC pinctrl nodes

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 14 ++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c  | 19 +++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxl.c   | 19 +++++++++++++++++++
 4 files changed, 66 insertions(+)

-- 
1.9.1
