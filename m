From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 4 May 2017 17:31:46 +0800
Subject: [PATCH v1 0/2] Add PCIe phy driver for some Mediatek SoCs
Message-ID: <1493890308-6159-1-git-send-email-ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series add PCIe phy driver and related dt-binding file for
Mediatek mt7623 SoCs families.

Changes since v1:
- revise binding document:
  drop 'status' properties.
  add a description to 'phy-switch' property and add vendor prefix.

Ryder Lee (2):
  phy: add PCIe PHY driver for mt7623 SoCs families
  dt-bindings: phy: Add documentation for Mediatek PCIe PHY

 .../devicetree/bindings/phy/phy-mt7623-pcie.txt    |  63 +++++
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-mt7623-pcie.c                      | 290 +++++++++++++++++++++
 4 files changed, 363 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mt7623-pcie.txt
 create mode 100644 drivers/phy/phy-mt7623-pcie.c

-- 
1.9.1
