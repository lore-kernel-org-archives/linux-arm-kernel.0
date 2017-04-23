From: ryder.lee@mediatek.com (Ryder Lee)
Date: Sun, 23 Apr 2017 16:17:31 +0800
Subject: [PATCH 0/2] Add PCIe phy driver for some Mediatek SoCs
Message-ID: <1492935453-17373-1-git-send-email-ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series add PCIe phy driver and related dt-binding file for
Mediatek mt7623 SoCs families.

Thanks.

Ryder Lee (2):
  phy: add PCIe phy driver for mt7623 SoCs families
  dt-bindings: phy: Add documentation for Mediatek PCIe PHY

 .../devicetree/bindings/phy/phy-mt7623-pcie.txt    |  67 +++++
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-mt7623-pcie.c                      | 290 +++++++++++++++++++++
 4 files changed, 367 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mt7623-pcie.txt
 create mode 100644 drivers/phy/phy-mt7623-pcie.c

-- 
1.9.1
