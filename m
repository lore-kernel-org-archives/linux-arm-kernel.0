From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu,  6 Sep 2018 18:40:30 +0900
Subject: [PATCH v2 0/2] add new UniPhier PCIe host driver
Message-ID: <1536226832-5089-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds PCIe host controller driver for Socionext UniPhier SoCs.
This controller is based on the DesignWare PCIe core. This driver
supports LD20 and PXs3 SoCs.

Changes since v1:
- follow capitalization conventions in the descriptions
- use C style comments except for the SPDX line

Kunihiko Hayashi (2):
  dt-bindings: PCI: add UniPhier PCIe host controller description
  PCI: controller: dwc: add UniPhier PCIe host controller support

 .../devicetree/bindings/pci/uniphier-pcie.txt      |  78 ++++
 drivers/pci/controller/dwc/Kconfig                 |   9 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-uniphier.c         | 465 +++++++++++++++++++++
 4 files changed, 553 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
 create mode 100644 drivers/pci/controller/dwc/pcie-uniphier.c

-- 
2.7.4
