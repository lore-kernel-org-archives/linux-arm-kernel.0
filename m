From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 21 Jun 2017 15:49:50 +0800
Subject: [PATCH 0/2] fixed ethernet binding violation for reset signal
Message-ID: <cover.1498030300.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Fixed binding violation and also updated related binding documentation to
reflect the reset signals the MediaTek Ethernet requires.

Sean Wang (2):
  dt-bindings: net: mediatek: update documentation for reset signals
  arm: dts: mt7623: fixup binding violation missing reset in ethernet
    node

 Documentation/devicetree/bindings/net/mediatek-net.txt | 6 ++++--
 arch/arm/boot/dts/mt7623.dtsi                          | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.7.4
