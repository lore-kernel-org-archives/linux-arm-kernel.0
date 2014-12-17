From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 17 Dec 2014 11:34:41 +0100
Subject: [PATCH 0/5] PCI: st: provide support for dw pcie
Message-ID: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set introduces a STMicroelectronics PCIe controler.
It's based on designware PCIe driver.

Gabriel Fernandez (5):
  ARM: STi: Kconfig update for PCIe support
  PCI: st: Add Device Tree bindings for sti pcie
  PCI: st: Provide support for the sti PCIe controller
  PCI: designware: Add setup bus-related to pcie_host_ops
  PCI: st: disable IO support

 Documentation/devicetree/bindings/pci/st-pcie.txt |  53 ++
 arch/arm/mach-sti/Kconfig                         |   2 +
 drivers/pci/host/Kconfig                          |   5 +
 drivers/pci/host/Makefile                         |   1 +
 drivers/pci/host/pci-st.c                         | 736 ++++++++++++++++++++++
 drivers/pci/host/pcie-designware.c                |   3 +
 drivers/pci/host/pcie-designware.h                |   1 +
 7 files changed, 801 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st-pcie.txt
 create mode 100644 drivers/pci/host/pci-st.c

-- 
1.9.1
