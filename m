From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 20 Jun 2017 10:12:57 +0200
Subject: [PATCH v9 0/3] Tango PCIe controller support
Message-ID: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Z pointed out that posting partial series is not ideal.
Collect last-minute fixups into a single patch series.

- Bump series to v9 to avoid any ambiguity
- Add Rob's Ack on patch 1

Marc Gonzalez (3):
  PCI: Add DT binding for tango PCIe controller
  PCI: Add tango PCIe host bridge support
  PCI: Add tango MSI controller support

 .../devicetree/bindings/pci/tango-pcie.txt         |  29 ++
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-tango.c                      | 390 +++++++++++++++++++++
 include/linux/pci_ids.h                            |   2 +
 5 files changed, 430 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
 create mode 100644 drivers/pci/host/pcie-tango.c

-- 
2.11.0
