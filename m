From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 21 Nov 2016 18:16:29 +0100
Subject: [PATCH] drm: tilcdc: reduce max_width for revision 1
Message-ID: <1479748590-3962-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While debugging the drm_bridge support for revision 1 I noticed the
driver was selecting the 1024x768 resolution as default from the set
retrieved from EDID. The following patch reduces the max_width for
rev1 in tilcdc.

Bartosz Golaszewski (1):
  drm: tilcdc: reduce max_width for revision 1

 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.9.3
