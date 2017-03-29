From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 29 Mar 2017 13:11:57 +0200
Subject: [PATCH v3 0/2] Tango PCIe controller support
Message-ID: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The patch is split in two parts, to ease review of two orthogonal
parts (MSI controller vs host bridge)

Marc Gonzalez (2):
  PCI: Add tango MSI controller support
  PCI: Add tango PCIe host bridge support

 Documentation/devicetree/bindings/pci/tango-pcie.txt |  34 ++++
 drivers/pci/host/Kconfig                             |   7 +
 drivers/pci/host/Makefile                            |   1 +
 drivers/pci/host/pcie-tango.c                        | 344 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 386 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
 create mode 100644 drivers/pci/host/pcie-tango.c

-- 
2.11.0
