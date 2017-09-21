From: guochun.mao@mediatek.com (Guochun Mao)
Date: Thu, 21 Sep 2017 20:45:04 +0800
Subject: [PATCH v1] mtk-nor: update dt bindings and add suspend/resume support
Message-ID: <1505997906-30921-1-git-send-email-guochun.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches affect mtk-quadspi module in mtk/spi-nor.
Add new compatible strings in dt bindings, add suspend/resume
support in mtk-quadspi driver.

Guochun Mao (2):
  dt-bindings: mtd: add new compatible strings and improve description
  mtd: mtk-nor: add suspend/resume support

 .../devicetree/bindings/mtd/mtk-quadspi.txt        | 15 +++--
 drivers/mtd/spi-nor/mtk-quadspi.c                  | 70 ++++++++++++++++++----
 2 files changed, 67 insertions(+), 18 deletions(-)

-- 
1.9.1
