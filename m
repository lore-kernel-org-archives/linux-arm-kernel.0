From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 15:31:01 +0800
Subject: [PATCH 0/2] Add device tree probe for i2c-mxs driver
Message-ID: <1336635063-11122-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds device tree probe support for i2c-mxs driver.  It
depends on mxs clk and pinctrl series.  Since all the dependencies
will probably be solved in arm-soc tree, it will be easier to have
it go through arm-soc.

Shawn Guo (2):
      i2c: mxs: add device tree probe support
      ARM: dts: enable i2c device for imx28-evk

 Documentation/devicetree/bindings/i2c/i2c-mxs.txt |   16 ++++++++++++++++
 arch/arm/boot/dts/imx28-evk.dts                   |    6 ++++++
 arch/arm/boot/dts/imx28.dtsi                      |   14 ++++++++++++++
 drivers/i2c/busses/i2c-mxs.c                      |   13 +++++++++++++
 4 files changed, 49 insertions(+), 0 deletions(-)
