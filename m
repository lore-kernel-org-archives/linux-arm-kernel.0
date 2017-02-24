From: yong.mao@mediatek.com (Yong Mao)
Date: Fri, 24 Feb 2017 16:22:06 +0800
Subject: [PATCH v1] Fixed bug where clock frequency could be set wrong
Message-ID: <1487924527-22584-1-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

yong mao (1):
  mmc: mediatek: Fixed bug where clock frequency could be set wrong

 drivers/mmc/host/mtk-sd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
1.8.1.1.dirty
