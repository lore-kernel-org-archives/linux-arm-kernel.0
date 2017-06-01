From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 1 Jun 2017 10:30:20 +0800
Subject: [PATCH v1 0/2] remove mediatek ethif clock in crypto driver
Message-ID: <1496284222-12560-1-git-send-email-ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series only remove redundant clock setting in mediatek crypto driver.

Changes since v1:
-rework the commit message.

Ryder Lee (2):
  crypto: mediatek - remove redundant clock setting
  dt-bindings: crypto: remove mediatek ethif clock

 Documentation/devicetree/bindings/crypto/mediatek-crypto.txt |  8 +++-----
 drivers/crypto/mediatek/mtk-platform.c                       | 10 +---------
 drivers/crypto/mediatek/mtk-platform.h                       |  2 --
 3 files changed, 4 insertions(+), 16 deletions(-)

-- 
1.9.1
