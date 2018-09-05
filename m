From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed,  5 Sep 2018 11:32:09 +0900
Subject: [PATCH 0/2] add new UniPhier PCIe host driver
Message-ID: <1536114731-28630-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds PCIe host controller driver for Socionext UniPhier SoCs.
This controller is based on the DesignWare PCIe core. This driver
supports LD20 and PXs3 SoCs.

Kunihiko Hayashi (2):
  dt-bindings: pci: add UniPhier PCIe host controller description
  pci: dwc: add UniPhier PCIe host controller support

 .../devicetree/bindings/pci/uniphier-pcie.txt      |  78 ++++
 drivers/pci/controller/dwc/Kconfig                 |   9 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-uniphier.c         | 464 +++++++++++++++++++++
 4 files changed, 552 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
 create mode 100644 drivers/pci/controller/dwc/pcie-uniphier.c

-- 
2.7.4
