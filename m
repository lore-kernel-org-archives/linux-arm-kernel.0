From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue, 29 May 2018 10:22:56 +0530
Subject: [PATCH 0/2] Add Mediatek X20 Development Board support
Message-ID: <20180529045258.1415-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree support for Mediatek X20 Development Board by Archermind.
This board is based on the Deca-Core MT6797 SoC from Mediatek and is
one of the 96Boards Consumer Edition platform.

With this devicetree change, board can boot into initramfs.

More information about this board can be found in 96Boards product page:
https://www.96boards.org/product/mediatek-x20/

Manivannan Sadhasivam (2):
  dt-bindings: Add vendor prefix for ArcherMind
  arm64: dts: Add Mediatek X20 Development Board support

 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts

-- 
2.17.0
