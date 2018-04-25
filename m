From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Wed, 25 Apr 2018 15:19:02 +0800
Subject: mmc: mediatek: add 64G DRAM DMA support
Message-ID: <1524640743-11732-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change vs V1:
	fix build warning of 32bit arch

Chaotian Jing (1):
  mmc: mediatek: add 64G DRAM DMA support

 drivers/mmc/host/mtk-sd.c | 56 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 7 deletions(-)

-- 
1.8.1.1.dirty
