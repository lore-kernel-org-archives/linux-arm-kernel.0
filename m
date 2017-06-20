From: leilk.liu@mediatek.com (Leilk Liu)
Date: Tue, 20 Jun 2017 16:21:05 +0800
Subject: [PATCH 0/2] add mt2712 spi support 
Message-ID: <1497946867-25708-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series are based on 4.12-rc1 and provide 2 patches to support mt2712 IC.

Change in this series:
1. update document to add mt2712;
2. add mt7622_compat.

Leilk Liu (2):
  spi: mediatek: Add bindings for mediatek MT2712 soc platform
  spi: mediatek: add spi support for mt2712 IC

 .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
 drivers/spi/spi-mt65xx.c                           |    7 +++++++
 2 files changed, 8 insertions(+)

--
1.7.9.5
