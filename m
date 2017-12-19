From: jun.gao@mediatek.com (Jun Gao)
Date: Tue, 19 Dec 2017 14:51:00 +0800
Subject: [PATCH 0/3] Add i2c dt-binding and compatible for Mediatek MT2712
Message-ID: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.15-rc1, include MT2712 i2c dt-binding, compatible
and i2c module clock enable.

Jun Gao (3):
  dt-bindings: i2c: Add MediaTek MT2712 i2c binding
  i2c: mediatek: Add i2c compatible for MediaTek MT2712
  i2c: mediatek: Enable i2c module clock before i2c registers access.

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |  1 +
 drivers/i2c/busses/i2c-mt65xx.c                   | 40 ++++++++++++++++++++---
 2 files changed, 37 insertions(+), 4 deletions(-)

--
1.8.1.1
