From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Thu, 25 Feb 2016 15:47:47 +0100
Subject: [PATCH v3 0/2] Add PCIe driver support for imx6sx
Message-ID: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3:
 * adapt devicetree bindings documentation fsl,imx6q-pcie.txt
v2:
 * leave out regulator handling from driver, will be done later
   in PM subsystem 
 * use BIT() macro for MFD

Christoph Fritz (2):
  MFD: imx6sx: Add PCIe register definitions for iomuxc gpr
  PCI: imx6: add initial imx6sx support

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
 drivers/pci/host/pci-imx6.c                        | 130 ++++++++++++++-------
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   5 +
 3 files changed, 101 insertions(+), 40 deletions(-)

-- 
2.1.4
