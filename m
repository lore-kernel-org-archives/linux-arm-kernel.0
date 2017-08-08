From: bhumirks@gmail.com (Bhumika Goyal)
Date: Tue,  8 Aug 2017 16:58:29 +0530
Subject: [PATCH 0/3] drm: make drm_connector_funcs structures const
Message-ID: <1502191712-11231-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare drm_connector_funcs structures as const.

Bhumika Goyal (3):
  drm/bridge: make drm_connector_funcs structures const
  drm/sun4i: make drm_connector_funcs structures const
  drm/rockchip: make drm_connector_funcs structures const

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c         | 2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c            | 2 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.9.1
