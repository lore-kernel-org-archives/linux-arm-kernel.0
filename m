From: john@metanate.com (John Keeping)
Date: Tue, 10 May 2016 17:03:53 +0100
Subject: [PATCH 0/3] drm/rockchip: fix some sparse warnings
Message-ID: <20160510160356.1167-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch wasn't found by sparse, but is something I noticed while
in the area.  The following two fix all of the sparse warnings inside
drm/rockchip.

John Keeping (3):
  drm/rockchip: dw_hdmi: remove unused #include
  drm/rockchip: fb: add missing header
  drm/rockchip: fix "should it be static?" warnings

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 1 -
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 4 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 7 ++++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.8.2.565.gdb84f68.dirty
