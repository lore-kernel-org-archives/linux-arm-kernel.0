From: biao.huang@mediatek.com (Biao Huang)
Date: Wed, 17 Feb 2016 03:16:32 +0800
Subject: [PATCH 0/2] pinctrl: mediatek: add setting for gpio and eint
Message-ID: <1455650194-9813-1-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. add input-enable setting in gpio_request_enable.
2. add input-enable and direction setting for eint resources.

Biao Huang (2):
  pinctrl: mediatek: add input-enable setting in gpio_request_enable
  pinctrl: mediatek: add input-enable and direction setting for eint
    resources

 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    5 +++++
 1 file changed, 5 insertions(+)

-- 
1.7.9.5
