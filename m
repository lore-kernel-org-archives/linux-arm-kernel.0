From: guochun.mao@mediatek.com (Guochun Mao)
Date: Fri, 13 Jan 2017 15:13:27 +0800
Subject: [PATCH v1 0/2] add nor flash node for mt2701
Message-ID: <1484291609-20195-1-git-send-email-guochun.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.10-rc2, include MT2701 spinor node and bindings.

Dependent on "Add clock and power domain DT nodes for Mediatek MT2701"[1].

[1] http://lists.infradead.org/pipermail/linux-mediatek/2016-December/007637.html

Guochun Mao (2):
  Documentation: mtk-quadspi: update DT bindings
  arm: dts: mt2701: add nor flash node

 .../devicetree/bindings/mtd/mtk-quadspi.txt        |  4 +++-
 arch/arm/boot/dts/mt2701-evb.dts                   | 25 ++++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi                      | 12 +++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

--
1.8.1.1.dirty
