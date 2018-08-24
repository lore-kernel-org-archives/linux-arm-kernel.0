From: hanjie.lin@amlogic.com (Hanjie Lin)
Date: Fri, 24 Aug 2018 15:33:24 +0800
Subject: [PATCH v2 0/2] add the Amlogic Meson PCIe phy driver
Message-ID: <1535096006-152091-1-git-send-email-hanjie.lin@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patcheset add the driver and dt-bindings for
the Meson-PCIE-PHY controller.

Changes since v1: [0]
 - move 'apb' and 'port' reset to ctrl driver
 - format correcting

[0] : https://lkml.org/lkml/2018/8/14/66 

Yue Wang (2):
  dt-bindings: phy: add DT bindings for Amlogic Meson PCIe Phy
    controller
  PCI: meson: add the Amlogic Meson PCIe phy driver

 .../bindings/phy/amlogic,meson-pcie-phy.txt        |  21 ++++
 drivers/phy/amlogic/Kconfig                        |   8 ++
 drivers/phy/amlogic/Makefile                       |   1 +
 drivers/phy/amlogic/phy-meson-axg-pcie.c           | 124 +++++++++++++++++++++
 4 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c

-- 
2.7.4
