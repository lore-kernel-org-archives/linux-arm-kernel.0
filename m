From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 30 May 2014 12:10:48 +0200
Subject: [PATCH 0/2] backlight: remove trivial get_brightness implementations
Message-ID: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes get_brightness callback optional
and removes trivial implementations.
Driver changes are quite obvious so I have put them into single
patch.

The patchset is based on the current linux-next branch.

Regards
Andrzej

Andrzej Hajda (2):
  backlight: show brightness even if get_brightness is not implemented
  backlight: remove trivial get_brightness implementations

 drivers/macintosh/via-pmu-backlight.c      | 6 ------
 drivers/platform/x86/samsung-q10.c         | 6 ------
 drivers/video/backlight/aat2870_bl.c       | 6 ------
 drivers/video/backlight/ams369fg06.c       | 6 ------
 drivers/video/backlight/backlight.c        | 2 ++
 drivers/video/backlight/bd6107.c           | 6 ------
 drivers/video/backlight/gpio_backlight.c   | 6 ------
 drivers/video/backlight/ld9040.c           | 6 ------
 drivers/video/backlight/lp855x_bl.c        | 6 ------
 drivers/video/backlight/lp8788_bl.c        | 6 ------
 drivers/video/backlight/lv5207lp.c         | 6 ------
 drivers/video/backlight/pandora_bl.c       | 6 ------
 drivers/video/backlight/pwm_bl.c           | 6 ------
 drivers/video/backlight/s6e63m0.c          | 6 ------
 drivers/video/backlight/tps65217_bl.c      | 6 ------
 drivers/video/fbdev/aty/aty128fb.c         | 6 ------
 drivers/video/fbdev/aty/atyfb_base.c       | 6 ------
 drivers/video/fbdev/aty/radeon_backlight.c | 6 ------
 drivers/video/fbdev/exynos/s6e8ax0.c       | 6 ------
 drivers/video/fbdev/nvidia/nv_backlight.c  | 6 ------
 drivers/video/fbdev/riva/fbdev.c           | 6 ------
 21 files changed, 2 insertions(+), 120 deletions(-)

-- 
1.9.1
