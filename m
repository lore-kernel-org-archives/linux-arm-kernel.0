From: chenyao11@huawei.com (Yao Chen)
Date: Wed, 9 May 2018 16:20:10 +0800
Subject: [PATCH v2 0/2] Add MSI support
Message-ID: <1525854012-24228-1-git-send-email-chenyao11@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes between V2 and V1
=========================
1. seperate DT binding patch.
2. fix issues according to review comments
   (1)from Bjorn Helgaas: Update the style of subject and changelog.
   (2)from Bjorn Helgaas: Add msi irq number in the message.
   (3)from Bjorn Helgaas: Delete unnecessary code 'pci->pp.root_bus_nr = -1'.
   (4)from Dmitry Shmidt: Fix typing error. Replace 'interrupts-names' of 'interrupt-names'.

Yao Chen (2):
  PCI: kirin: Add MSI support
  arm64: dts: hi3660: Add pcie msi interrupt attribute

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi |  2 ++
 drivers/pci/dwc/pcie-kirin.c              | 39 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

-- 
1.9.1
