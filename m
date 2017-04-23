From: ryder.lee@mediatek.com (Ryder Lee)
Date: Sun, 23 Apr 2017 16:19:01 +0800
Subject: [PATCH 0/2] Add PCIe host driver support for some Mediatek SoCs
Message-ID: <1492935543-18190-1-git-send-email-ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series add PCIe host controller driver and dt-binding
documentation for Mediatek mt7623 SoCs families.

This driver was validated using Broadcom Tigon3 ethernet card.

Ryder Lee (2):
  PCI: mediatek: Add Mediatek PCIe host controller support
  dt-bindings: pcie: Add documentation for Mediatek PCIe

 .../bindings/pci/mediatek,mt7623-pcie.txt          | 153 ++++++
 drivers/pci/host/Kconfig                           |  11 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-mediatek.c                   | 611 +++++++++++++++++++++
 4 files changed, 776 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
 create mode 100644 drivers/pci/host/pcie-mediatek.c

-- 
1.9.1
