From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 1 Nov 2018 14:02:17 +0800
Subject: add SPI driver support for mt8183 
Message-ID: <1541052139-8845-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 44b1c34bc19d9bfdc736664439c0530fbb2c75b8 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Thu, 1 Nov 2018 11:48:20 +0800
Subject: [PATCH 0/2] add SPI driver support for mt8183

This series are based on 4.19-rc1 and provide two patches to support mt8183 IC.

Leilk Liu (2):
  spi: mediatek: Add bindings for mediatek MT8183 soc platform
  spi: mediatek: add spi support for mt8183 IC

 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
 drivers/spi/spi-mt65xx.c                             | 9 +++++++++
 2 files changed, 10 insertions(+)

-- 
2.19.1
