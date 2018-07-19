From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 19 Jul 2018 16:24:48 +0530
Subject: [PATCH v3 0/2] Add Mediatek X20 Development Board support
Message-ID: <1531997690-6040-1-git-send-email-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree support for Mediatek X20 Development Board by Archermind.
This board is based on the Deca-Core MT6797 SoC from Mediatek and is
one of the 96Boards Consumer Edition platform.

With this devicetree change, board can boot into initramfs.

More information about this board can be found in 96Boards product page:
https://www.96boards.org/product/mediatek-x20/

Thanks,
Mani

Changes in v3:

* Modified the memory size to 2GB (0x80000000) in board DTS

Changes in v2:

* Added documentation for board compatible
* Dropped vendor documetation patch since it got applied

Manivannan Sadhasivam (2):
  dt-bindings: arm: mediatek: Document Mediatek X20 Development Board
  arm64: dts: Add Mediatek X20 Development Board support

 Documentation/devicetree/bindings/arm/mediatek.txt |  3 ++
 arch/arm64/boot/dts/mediatek/Makefile              |  1 +
 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts    | 33 ++++++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts

-- 
2.7.4
