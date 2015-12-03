From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 3 Dec 2015 23:19:57 +0800
Subject: [RFC PATCH 0/2] PCI/ACPI: HiSi: Add ACPI support for Hip05 PCIe Host
 Bridge Controller
Message-ID: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on Nowicki patchset:
[PATCH V1 00/11] MMCONFIG refactoring and ARM64 PCI hostbridge init based on ACPI

This patchset:
1) adds ACPI support for non ECAM PCI Host Bridge Controllers
2) adds ACPI support for Hip05 PCIe Host Bridge Controller

Gabriele Paoloni (1):
  PCI/ACPI: Add ACPI support for non ECAM Host Bridge Controllers

Gabriele Paoloni (1):
  PCI/ACPI: HiSi: Add ACPI support for HiSi PCIe Host Bridge

 arch/arm64/kernel/Makefile        |   1 +
 arch/arm64/kernel/pci.c           |  42 ++++++++
 arch/arm64/kernel/pci_acpi_hisi.c | 198 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/pci_quirks.h    |  24 +++++
 drivers/acpi/pci_root.c           |   4 +
 include/acpi/acpi_drivers.h       |   6 ++
 6 files changed, 275 insertions(+)
 create mode 100644 arch/arm64/kernel/pci_acpi_hisi.c
 create mode 100644 arch/arm64/kernel/pci_quirks.h

-- 
1.9.1
