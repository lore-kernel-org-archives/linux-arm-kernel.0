From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  4 May 2016 11:43:15 +0200
Subject: [PATCH v2 0/3] video: fbdev: imxfb: make it work again
Message-ID: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this is v2 of the series which addresses the review comments I got vor
(implicit) v1.

For patch 2 the question is still open if this is the right fix, but
without this the display doesn't stay on. Patches 1 and 3 should be
applicable independant of patch 2.

Best regards
Uwe

Uwe Kleine-K?nig (3):
  video: fbdev: imxfb: fix semantic of .get_power and .set_power
  video: fbdev: imxfb: enable lcd regulator in .probe
  video: fbdev: imxfb: add some error handling

 drivers/video/fbdev/imxfb.c | 53 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 12 deletions(-)

-- 
2.8.0.rc3
