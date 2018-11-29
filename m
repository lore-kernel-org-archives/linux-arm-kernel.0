From: jian.hu@amlogic.com (Jian Hu)
Date: Thu, 29 Nov 2018 18:59:54 +0800
Subject: [PATCH 0/2] i2c: meson: add support for Meson G12A SoC i2c controller
Message-ID: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1)Add G12A SoC i2c compatible string in dt-bindings.
2)Add compatible and data for G12A I2C controller driver.

Jian Hu (2):
  dt-bindings: i2c: meson: add Meson G12A SoC i2c compatible string
  i2c: meson: add support for Meson G12A SoC I2C controller

 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
 drivers/i2c/busses/i2c-meson.c                      | 5 +++++
 2 files changed, 6 insertions(+)

-- 
1.9.1
