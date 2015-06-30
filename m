From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 30 Jun 2015 12:24:44 +0530
Subject: [PATCH v1 0/4] Add support for touchscreen on Colibri VF50
Message-ID: <cover.1435646447.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The patchset adds support for 4 wire touchscreen on Toradex Colibri
VF50 modules. Patches are based on top of shawn's branch.

Thanks & Regards,
Sanchayan.

Sanchayan Maity (4):
  ARM: dts: vfxxx: Add io-channel-cells property for ADC node
  ARM: dts: vf500-colibri: Add device tree node for touchscreen support
  touchscreen: colibri-vf50-ts: Add touchscreen support for Colibri VF50
  input: Add DT binding documentation for Colibri VF50 touchscreen

 .../bindings/input/touchscreen/colibri-vf50-ts.txt |  34 ++
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts        |   4 +
 arch/arm/boot/dts/vf500-colibri.dtsi               |  46 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |   2 +
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/colibri-vf50-ts.c        | 466 +++++++++++++++++++++
 7 files changed, 565 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
 create mode 100644 drivers/input/touchscreen/colibri-vf50-ts.c

-- 
2.4.5
