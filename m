From: yong.mao@mediatek.com (Yong Mao)
Date: Sat, 4 Mar 2017 15:10:02 +0800
Subject: [PATCH v2] mmc: mediatek: Fixed bug where clock frequency could be
 set wrong
Message-ID: <1488611403-30186-1-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

yong mao (1):
  mmc: mediatek: Fixed bug where clock frequency could be set wrong

 drivers/mmc/host/mtk-sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.1.1.dirty
