From: bhumirks@gmail.com (Bhumika Goyal)
Date: Tue, 20 Jun 2017 18:37:58 +0530
Subject: [PATCH 0/2] drm: constify drm_encoder_helper_funcs structures 
Message-ID: <1497964080-27301-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add const to drm_encoder_helper_funcs structures.

Bhumika Goyal (2):
  drm/rockchip: add const to drm_encoder_helper_funcs structures
  drm/sun4i: add const to drm_encoder_helper_funcs structures

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 3 ++-
 drivers/gpu/drm/rockchip/inno_hdmi.c            | 2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c               | 2 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.7.4
