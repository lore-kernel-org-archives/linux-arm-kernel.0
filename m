From: jun.gao@mediatek.com (Jun Gao)
Date: Sat, 7 Jul 2018 10:49:10 +0800
Subject: [PATCH 0/3] Register i2c adapter driver earlier and use DMA safe
 buffers
Message-ID: <1530931753-8264-1-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.18-rc1, include i2c adapter driver register time
modification, DMA safe buffer free function and DMA safe buffers used for i2c
transactions.

Jun Gao (3):
  i2c: mediatek: Register i2c adapter driver earlier
  i2c: Add helper to ease DMA handling
  i2c: mediatek: Use DMA safe buffers for i2c transactions

 drivers/i2c/busses/i2c-mt65xx.c | 74 ++++++++++++++++++++++++++++++++++++-----
 drivers/i2c/i2c-core-base.c     | 14 ++++++++
 include/linux/i2c.h             |  1 +
 3 files changed, 81 insertions(+), 8 deletions(-)

--
1.8.1.1
