From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 31 Jul 2011 02:21:25 +0800
Subject: [PATCH v2 0/2] Add device tree probe for i2c-imx driver
Message-ID: <1312050087-15701-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch removes unused init/exit hooks from platform data,
and the second one actually adds the actual device tree probe support.

Changes since v1:
 * Fix a couple of typo in fsl-imx-i2c.txt

Shawn Guo (2):
      i2c/imx: remove init/exit hooks from platform data
      i2c/imx: add device tree probe support

 .../devicetree/bindings/i2c/fsl-imx-i2c.txt        |   25 +++++++++++
 arch/arm/plat-mxc/include/mach/i2c.h               |    4 --
 drivers/i2c/busses/i2c-imx.c                       |   46 +++++++++----------
 3 files changed, 47 insertions(+), 28 deletions(-)
