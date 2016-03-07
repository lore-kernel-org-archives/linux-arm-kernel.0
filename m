From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  7 Mar 2016 20:53:42 +0100
Subject: [PATCH 0/3] video: fbdev: imxfb: make it work again
Message-ID: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

it seems the imxfb driver stopped working quite some time ago. Here come
some fixes to convince the driver to operate again. This is a cleanup of
the RFC patch "video: fbdev: imxfb: make the driver cooperate" I sent
last week (Message-Id:
1456829223-1526-1-git-send-email-u.kleine-koenig at pengutronix.de).

Best regards
Uwe

Uwe Kleine-K?nig (3):
  video: fbdev: imxfb: fix semantic of .get_power and .set_power
  video: fbdev: imxfb: enable lcd regulator in .probe
  video: fbdev: imxfb: add some error handling

 drivers/video/fbdev/imxfb.c | 48 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

-- 
2.7.0
