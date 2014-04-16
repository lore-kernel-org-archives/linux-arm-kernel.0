From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 16 Apr 2014 13:41:53 +0900
Subject: [RFC PATCH 0/2] Add support for Samsung GH7 PCIe controller
Message-ID: <000801cf592e$30b7bff0$92273fd0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Samsung GH7 PCIe host controller.
Samsung GH7 PCIe controller driver has dependency on the PCI arm64
arch support. So, the Liviu Dudau's patcheset for creating generic
host_bridge from device tree [1] and supporting PCI in AArch64 [2]
are required.

This patch is marked as RFC, so any comment will be welcomed.
Thank you.

[1] http://www.spinics.net/lists/linux-pci/msg29786.html
[2] http://www.spinics.net/lists/linux-pci/msg29793.html

Jingoo Han (2)
  PCI: designware: Add ARM64 PCI support
  PCI: exynos: Add PCIe support for Samsung GH7 SoC

---
 drivers/pci/host/Kconfig           |    2 +-
 drivers/pci/host/pci-exynos.c      |  135 +++++++++++++++++++++++++++++++++---
 drivers/pci/host/pcie-designware.c |   32 +++++++++
 3 files changed, 158 insertions(+), 11 deletions(-)

Best regards,
Jingoo Han
