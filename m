From: leilk.liu@mediatek.com (Leilk Liu)
Date: Tue, 27 Nov 2018 10:29:49 +0800
Subject: [PATCH v2 0/1] add SPI driver support for mt7629 
Message-ID: <1543285790-11379-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From cf719ac350c36cb58e2013b58f73ad04f6981384 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Tue, 27 Nov 2018 10:18:30 +0800
Subject: [PATCH v2 0/1] add SPI driver support for mt7629

v2:
remove "mediatek,mt7629-spi" compatible according Matthias's advice.

v1:
This series are based on 4.20-rc1 and provide two patches to support mt7629 IC.

Leilk Liu (1):
  spi: mediatek: Add bindings for mediatek MT7629 soc platform

 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

-- 
1.9.1
