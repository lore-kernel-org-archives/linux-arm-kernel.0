From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 15 Sep 2011 23:39:51 +0800
Subject: [PATCH v3 0/2] Add device tree probe for i2c-imx driver
Message-ID: <1316101193-4295-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

Hopefully, you can pick up this version.

Thanks.

Changes since v2:
 * Drop HS-I2C from binding document fsl-imx-i2c.txt

Changes since v1:
 * Fix a couple of typo in fsl-imx-i2c.txt

Shawn Guo (2):
      i2c-imx: remove init/exit hooks from platform data
      i2c-imx: add device tree probe support

 .../devicetree/bindings/i2c/fsl-imx-i2c.txt        |   18 ++++++++
 arch/arm/plat-mxc/include/mach/i2c.h               |    4 --
 drivers/i2c/busses/i2c-imx.c                       |   46 +++++++++----------
 3 files changed, 40 insertions(+), 28 deletions(-)
