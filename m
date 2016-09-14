From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 14 Sep 2016 11:49:15 +0200
Subject: [PATCH 0/2] i2c: meson: add gxbb compatible string
Message-ID: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds a specific compatible string in the Meson I2C driver
for the Amlogic Meson gxbb SoC.

Other patch series (pinctrl and device tree) are being sent to complete
the i2c support on meson gxbb

Neil Armstrong (2):
  i2c: meson: add gxbb compatible string
  dt-bindings: i2c-meson: add gxbb compatible string

 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 2 +-
 drivers/i2c/busses/i2c-meson.c                      | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4
