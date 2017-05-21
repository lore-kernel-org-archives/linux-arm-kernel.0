From: ryder.lee@mediatek.com (Ryder Lee)
Date: Sun, 21 May 2017 11:43:10 +0800
Subject: [PATCH v2 0/2] Add PCIe phy driver for some Mediatek SoCs
Message-ID: <1495338192-9423-1-git-send-email-ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series add PCIe phy driver and related dt-binding file for
Mediatek mt7623 SoCs families.

Changes since v2:
- rebase to Linux 4.12-rc1

Changes since v1:
- revise binding document:
  drop 'status' properties.
  add a description to 'phy-switch' property and add vendor prefix.

Ryder Lee (2):
  phy: add PCIe PHY driver for mt7623 SoCs families
  dt-bindings: phy: Add documentation for Mediatek PCIe PHY

 .../devicetree/bindings/phy/phy-mt7623-pcie.txt    |  63 +++++
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-mt7623-pcie.c                      | 290 +++++++++++++++++++++
 4 files changed, 362 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mt7623-pcie.txt
 create mode 100644 drivers/phy/phy-mt7623-pcie.c

-- 
1.9.1
