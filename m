From: yong.mao@mediatek.com (Yong Mao)
Date: Wed, 15 Mar 2017 15:26:37 +0800
Subject: [PATCH v5 0/3] Use data tune for CMD line tune 
Message-ID: <1489562800-27431-1-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

yong mao (3):
  mmc: dt-bindings: update Mediatek MMC bindings
  ARM64: dts: mediatek: configure some fixed mmc parameters
  mmc: mediatek: Use data tune for CMD line tune

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |  12 ++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |   3 +
 drivers/mmc/host/mtk-sd.c                        | 168 ++++++++++++++++++++---
 3 files changed, 167 insertions(+), 16 deletions(-)

-- 
1.8.1.1.dirty
