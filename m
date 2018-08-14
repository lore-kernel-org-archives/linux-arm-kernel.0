From: hanjie.lin@amlogic.com (Hanjie Lin)
Date: Tue, 14 Aug 2018 02:12:12 -0400
Subject: [PATCH 0/2] add the Amlogic Meson PCIe phy driver.
Message-ID: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patcheset add the driver and dt-bindings for
the Meson-PCIE-PHY controller.

Yue Wang (2):
  dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe Phy
    controller
  PCI: meson: add the Amlogic Meson PCIe phy driver

 .../bindings/phy/amlogic,meson-pcie-phy.txt        |  31 ++++
 drivers/phy/amlogic/Kconfig                        |   8 ++
 drivers/phy/amlogic/Makefile                       |   1 +
 drivers/phy/amlogic/phy-meson-axg-pcie.c           | 160 +++++++++++++++++++++
 4 files changed, 200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c

-- 
2.7.4
