From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 31 Dec 2015 10:58:59 +0800
Subject: [PATCH 0/4] SPI: support mt2701 IC
Message-ID: <1451530743-8995-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series are based on 4.4-rc1 and provide 4 patches to support
mt2701 spi HW.

Change in this series:
1. merge all identical compat to mtk_common_compat;
2. Add spi support for mt2701 IC;
3. add spi dts for mt2701;
4. Add bindings for mediatek MT2701 soc platform.

Leilk Liu (4):
  spi: mediatek: merge all identical compat to mtk_common_compat
  spi: mediatek: Add spi support for mt2701 IC
  dts: mt2701: add spi dts for mt2701
  Document: spi: Add bindings for mediatek MT2701 soc platform

 .../devicetree/bindings/spi/spi-mt65xx.txt         |    5 ++-
 arch/arm/boot/dts/mt2701.dtsi                      |   39 ++++++++++++++++++++
 drivers/spi/spi-mt65xx.c                           |   18 ++++++---
 3 files changed, 55 insertions(+), 7 deletions(-)

--
1.7.9.5
