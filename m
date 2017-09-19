From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 19 Sep 2017 14:27:20 +0800
Subject: [PATCH v1 0/4] update MT7623 and MT2701 dts
Message-ID: <cover.1505801355.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series corrects some nodes for both MT7623 and MT2701, adds display and
PCIe support for MT7623.

changes since v1:
- rebase to v4.14.
- sort nodes in alphabetical order.

Ryder Lee (4):
  arm: dts: mediatek: update audio node for mt2701 and mt7623
  arm: dts: mt7623: update pio, usb and crypto nodes
  arm: dts: mt7623: add display related nodes
  arm: dts: mt7623: add PCIe related nodes

 arch/arm/boot/dts/mt2701.dtsi                 |   4 +-
 arch/arm/boot/dts/mt7623.dtsi                 | 374 ++++++++++++++++++++++++--
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  71 ++++-
 include/dt-bindings/pinctrl/mt7623-pinfunc.h  |  12 +
 4 files changed, 432 insertions(+), 29 deletions(-)

-- 
1.9.1
