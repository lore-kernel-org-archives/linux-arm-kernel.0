From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 9 Mar 2015 17:28:05 +0800
Subject: [PATCH 0/3] imx: add max7310 and usb support for imx6qdl sabreauto
Message-ID: <1425893288-1517-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

In this series, two functions are added for imx6qdl sabreauto board.

- In the 1st patch, the i2c interface gpio expendor max7310 is added
- In the 2nd patch, the USB support is added
- In the 3rd patch, the driver for max7310 is added

Peter Chen (3):
  ARM: imx6qdl-sabreauto.dtsi: add max7310 support
  ARM: imx6qdl-sabreauto.dtsi: enable USB support
  ARM: imx_v6_v7_defconfig: Add CONFIG_GPIO_PCA953X

 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 87 ++++++++++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig     |  1 +
 2 files changed, 88 insertions(+)

-- 
1.9.1
