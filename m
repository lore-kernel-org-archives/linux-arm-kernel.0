From: lisovy@gmail.com (Rostislav Lisovy)
Date: Thu, 24 Oct 2013 23:56:06 +0200
Subject: [PATCH 0/3 v3] Devicetree description for Voipac i.MX53 module
Message-ID: <1382651769-21238-1-git-send-email-lisovy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds devicetree description for Voipac X53-DMM-668 module
which uses i.MX53 CPU. More information about the module may be found at:
http://www.voipac.com/#X53-DMM-668
The support for the baseboard used with this module is also provided.
More information about the baseboard: http://www.voipac.com/#X25-BSB-000

Working peripherals are:
* UART0
* Ethernet
* Buttons (with keyboard controller)
* Sound (headphone output)
* SD-card
* LEDs (through GPIOs)
* i2c1, i2c3
* ecspi1

Changes since v2:
* Changed (and properly added) Vendor prefix

Changes since v1:
* Minor fixes according to comments by Shawn Guo

Rostislav Lisovy (2):
  ARM: dts: i.MX53: dts for Voipac x53-dmm-668 module
  ARM: dts: i.MX53: Devicetree for Voipac Baseboard using x53-dmm-668
    module

 arch/arm/boot/dts/Makefile                  |    1 +
 arch/arm/boot/dts/imx53-voipac-bsb.dts      |  135 +++++++++++++++++++
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi |  193 +++++++++++++++++++++++++++
 3 files changed, 329 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-voipac-bsb.dts
 create mode 100644 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi

-- 
1.7.10.4
