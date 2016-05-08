From: serveralex@gmail.com (=?UTF-8?q?Alexander=20M=C3=BCller?=)
Date: Sun,  8 May 2016 19:59:48 +0200
Subject: [PATCH] pinctrl: meson: Fix eth_tx_en bit index
Message-ID: <1462730389-10961-1-git-send-email-serveralex@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes a bad bit index in preparation for ethernet support on ODROID-C1.

Alexander M?ller (1):
  pinctrl: meson: Fix eth_tx_en bit index

 drivers/pinctrl/meson/pinctrl-meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.5.0
