From: guochun.mao@mediatek.com (Guochun Mao)
Date: Mon, 18 Dec 2017 09:47:34 +0800
Subject: [PATCH V1 1/1] mtd: mtk-nor: modify functions' name more generally
Message-ID: <1513561655-10570-1-git-send-email-guochun.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since more and more Mediatek's SoC can use this driver to control
spi-nor flash, functions' name with "mt8173_" is no longer properly.
Replacing "mt8173_" with "mtk_" will be more accurate to describe
these functions' usable scope.

Guochun Mao (1):
  mtd: mtk-nor: modify functions' name more generally

 drivers/mtd/spi-nor/mtk-quadspi.c | 240 +++++++++++++++++++-------------------
 1 file changed, 120 insertions(+), 120 deletions(-)

-- 
1.9.1
