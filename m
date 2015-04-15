From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Wed, 15 Apr 2015 14:04:00 +0800
Subject: [RFC PATCH 0/3] PCI: host: Add PCIe host support for Hisilicon Soc
 Hip05
Message-ID: <1429077843-184462-1-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds PCIe host support for Hisilicon Soc Hip05. The PCIe hosts
use PCIe IP core from Synopsys. So the driver is based on designware PCIe driver.

Zhou Wang (3):
  PCI: host: designware: support ARM64
  PCI: Host: Add PCIe host support for Hisilicon Soc Hip05
  Documentation: devicetree: Add hisilicon PCIe host binding

 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  46 ++++
 drivers/pci/host/Kconfig                           |   5 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-designware.c                 |  44 +++-
 drivers/pci/host/pcie-hisi.c                       | 252 +++++++++++++++++++++
 5 files changed, 345 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 create mode 100644 drivers/pci/host/pcie-hisi.c

-- 
1.9.1
