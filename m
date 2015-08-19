From: leilk.liu@mediatek.com (Leilk Liu)
Date: Wed, 19 Aug 2015 11:37:55 +0800
Subject: [PATCH 0/3] Fixup mediatek spi driver
Message-ID: <1439955478-2733-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change in this patch:
1. revise coding styles.
2. delete redundant clock in prepare/unprepare_hardware.
3. fix incorrect endian usage on big-endian system.

Leilk Liu (3):
  spi: mediatek: revise coding style
  spi: mediatek: remove redundant clock in
    prepare_hardware/unprepare_hardware
  spi: mediatek: fix spi incorrect endian usage

 drivers/spi/spi-mt65xx.c                 | 169 +++++++++++++------------------
 include/linux/platform_data/spi-mt65xx.h |   2 -
 2 files changed, 73 insertions(+), 98 deletions(-)

--
1.8.1.1.dirty
