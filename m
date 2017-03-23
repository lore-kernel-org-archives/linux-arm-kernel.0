From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 23 Mar 2017 17:50:53 +0100
Subject: [PATCH 0/8] pinctrl: meson: add audio output pins
Message-ID: <20170323165101.29262-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the pinctrl definition and the related device-tree
bindings of the i2s output and spdif output pins on the meson gxbb and
gxl SoCs.

This is part of the ongoing work to bring audio output suppot on the
meson family. It was tested on the gxbb p200 and gxl p230.

Jerome Brunet (8):
  pinctrl: meson: gxbb: add i2s output pins
  pinctrl: meson: gxbb: add spdif output pins
  pinctrl: meson: gxl: add i2s output pins
  pinctrl: meson: gxl: add spdif output pins
  ARM64: dts: meson-gxbb: add i2s output pins
  ARM64: dts: meson-gxbb: add spdif output pins
  ARM64: dts: meson-gxl: add i2s output pins
  ARM64: dts: meson-gxl: add spdif output pins

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 84 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 83 ++++++++++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c  | 49 +++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxl.c   | 49 +++++++++++++++++
 4 files changed, 265 insertions(+)

-- 
2.9.3
