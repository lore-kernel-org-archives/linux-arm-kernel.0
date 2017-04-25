From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 25 Apr 2017 23:25:02 +0800
Subject: [PATCH 0/3] drm/sun4i: More cleanups and fixes
Message-ID: <20170425152505.6796-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

The subject is probably getting old. Here are a few more cleanups.

Patch 1 should have been part of the patch

    drm/sun4i: Use lists to track registered display backends and TCONs

from my multiple pipeline support series. Please squash it in if you can.

Patch 2 just moves setting the TCON clocks back inside the TCON driver.

Patch 3 cleans up a DRM driver debug message.

Regards
ChenYu


Chen-Yu Tsai (3):
  drm/sun4i: Drop unused tcon pointer
  drm/sun4i: Set TCON clock inside sun4i_tconX_mode_set
  drm/sun4i: backend: Clarify sun4i_backend_layer_enable debug message

 drivers/gpu/drm/sun4i/sun4i_backend.c | 3 ++-
 drivers/gpu/drm/sun4i/sun4i_drv.h     | 1 -
 drivers/gpu/drm/sun4i/sun4i_rgb.c     | 2 --
 drivers/gpu/drm/sun4i/sun4i_tcon.c    | 6 ++++++
 drivers/gpu/drm/sun4i/sun4i_tv.c      | 2 --
 5 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.11.0
