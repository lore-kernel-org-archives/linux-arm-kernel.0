From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 12 Jun 2017 09:24:38 +0800
Subject: [PATCH v3 0/2] add mt7622 spi support 
Message-ID: <1497230680-20448-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series are based on 4.12-rc1 and provide 2 patches to support mt7622 IC.

Change in v3:
fix build error.

Change in v2:
1. rename patch title;
2. use enhance_timing to instead of adjust_reg.

Change in v1:
1. update document to add mt7622;
2. add adjust register define support;
3. add mt7622_compat.

Leilk Liu (2):
  spi: mediatek: adjust register to enhance time accuracy
  spi: mediatek: add spi support for mt7622 IC

 drivers/spi/spi-mt65xx.c                 |   54 +++++++++++++++++++++++++++---
 include/linux/platform_data/spi-mt65xx.h |    2 ++
 2 files changed, 51 insertions(+), 5 deletions(-)

--
1.7.9.5
