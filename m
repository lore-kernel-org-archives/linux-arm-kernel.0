From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 14:10:39 +0000
Subject: [PATCH 00/12] ARM: dts: apq8064: spi and i2c dt patches
Message-ID: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy, 

Here are some apq8064 dts patches which are mostly to do with spi and i2c.

Most of the patches are additions of missing nodes required for ifc6410.

thanks,
srini

Srinivas Kandagatla (12):
  ARM: dts: qcom: fix i2c lables to be inline with others
  ARM: dts: apq8064: move pinctrls to dedicated dtsi
  ARM: dts: apq8064: add pci support in CM QS600
  ARM: dts: apq8064: add i2c sleep pinctrl states.
  ARM: dts: apq8064: add spi5 device node.
  ARM: dts: ifc6410: enable spi device on expansion
  ARM: dts: apq8064: add missing i2c2 pinctrl info
  ARM: dts: ifc6410: enable i2c2 on expansion connector
  ARM: dts: apq8064: add gsbi4 with i2c node.
  ARM: dts: ifc6410: enable cam i2c device
  ARM: dts: apq8064: add i2c6 device node.
  ARM: dts: ifc6410: add correct aliases to the i2c and spi bus

 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts |  27 ++++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts  |  35 ++++-
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi    | 208 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi         | 126 ++++++++---------
 4 files changed, 329 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-pins.dtsi

-- 
1.9.1
