From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Oct 2017 19:35:10 +0800
Subject: [PATCH v2 0/2] Add HiSilicon INNO USB2 PHY driver support
Message-ID: <1508758512-22900-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds device tree bindings and driver support for HiSilicon INNO USB2
PHY device, which can be found on HiSilicon STB SoC Hi3798cv200.

Changes for v2:
 - Move DT bindings into a separate patch.
 - Rename hisi_inno_phy_start() to hisi_inno_phy_init() for aligning
   name with .init hook.

Pengcheng Li (2):
  dt-bindings: add bindings doc for HiSilicon INNO USB2 PHY
  phy: add inno-usb2-phy driver for hi3798cv200 SoC

 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  31 +++
 drivers/phy/hisilicon/Kconfig                      |  10 +
 drivers/phy/hisilicon/Makefile                     |   1 +
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         | 224 +++++++++++++++++++++
 4 files changed, 266 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
 create mode 100644 drivers/phy/hisilicon/phy-hisi-inno-usb2.c

-- 
1.9.1
