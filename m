From: biao.huang@mediatek.com (Biao Huang)
Date: Wed, 3 Feb 2016 09:24:44 +0800
Subject: [PATCH 0/2] pinctrl: mediatek: Add direction control and
 gpio_request_enable Support
Message-ID: <1454462686-770-1-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Set direction to input when do input-enable/disable and input-schmitt-enable/disable properties.
2. Add gpio_request_enable support to set pin to gpio function.

Biao Huang (2):
  pinctrl: mediatek: fix direction control issue
  pinctrl: mediatek: Add gpio_request_enable support

 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

-- 
1.7.9.5
