From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 29 Nov 2017 18:10:34 +0800
Subject: [PATCH 0/3] Misc fixes up for MT7623 mmc
Message-ID: <cover.1511949769.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Just add some fixes up for the current MT7623 support

Patch 1) complement the missing dt-bindings definitions
Patch 2) pick up the proper falling back as patch 1 defines.
Patch 3) SD-card detection issue caused by the wrong polarity is being fixed up

Sean Wang (3):
  mmc: dt-bindings: add mmc support to MT7623 SoC
  arm: dts: mt7623: update mmc related nodes with the appropriate
    fallback
  arm: dts: mt7623: fix card detection issue on bananapi-r2

 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 2 ++
 arch/arm/boot/dts/mt7623.dtsi                    | 4 ++--
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts    | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.7.4
