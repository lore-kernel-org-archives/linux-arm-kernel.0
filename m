From: jun.gao@mediatek.com (Jun Gao)
Date: Wed, 9 Aug 2017 15:43:49 +0800
Subject: [PATCH 0/2] Add i2c dt-binding and compatible for Mediatek MT7622 SoC
Message-ID: <1502264631-12572-1-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.13-rc1, include MT7622 i2c dt-binding
and compatible.

Jun Gao (2):
  dt-bindings: i2c: Add MediaTek MT7622 i2c binding
  i2c: mediatek: Add i2c compatible for MediaTek MT7622

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 11 ++++++-----
 drivers/i2c/busses/i2c-mt65xx.c                   | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

--
1.8.1.1
