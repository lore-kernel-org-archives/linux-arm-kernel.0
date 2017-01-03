From: yong.mao@mediatek.com (Yong Mao)
Date: Tue, 3 Jan 2017 16:49:55 +0800
Subject: [PATCH v2] Fix CMD6 timeout issue 
Message-ID: <1483433397-11756-1-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

yong mao (2):
  mmc: core: Fix CMD6 timeout issue
  mmc: mediatek: correct the implementation of msdc_card_busy

 drivers/mmc/core/core.c   | 19 +++++++++++++++++++
 drivers/mmc/host/mtk-sd.c |  7 ++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
1.8.1.1.dirty
