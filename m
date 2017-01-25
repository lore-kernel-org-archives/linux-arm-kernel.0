From: guochun.mao@mediatek.com (Guochun Mao)
Date: Wed, 25 Jan 2017 11:38:33 +0800
Subject: [PATCH v2 0/2] addr nor flash node for mt2701
Message-ID: <1485315515-29942-1-git-send-email-guochun.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update DT bindings, clarify compatible strings that mt2701-nor node should contain. 
This patch series based on v4.10-rc2, include MT2701 spi nor node.
Dependent on "Add clock and power domain DT nodes for Mediatek MT2701"
[1] http://lists.infradead.org/pipermail/linux-mediatek/2016-December/007637.html

Guochun Mao (2):
  Documentation: mtk-quadspi: update DT bindings
  arm: dts: mt2701: add nor flash node

 .../devicetree/bindings/mtd/mtk-quadspi.txt        |  8 ++++++-
 arch/arm/boot/dts/mt2701-evb.dts                   | 25 ++++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi                      | 12 +++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

-- 
1.8.1.1.dirty
