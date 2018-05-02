From: peda@axentia.se (Peter Rosin)
Date: Wed,  2 May 2018 09:40:22 +0200
Subject: [PATCH 0/3] drm: fix some bridge api misunderstandings
Message-ID: <20180502074025.12421-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

While looking at various drm bridge users, I came across these
issues.

Cheers,
Peter

Peter Rosin (3):
  drm/sti: do not remove the drm_bridge that was never added
  drm/rockchip: lvds: avoid duplicating drm_bridge_attach
  drm/exynos: hdmi: avoid duplicating drm_bridge_attach

 drivers/gpu/drm/exynos/exynos_hdmi.c     | 2 --
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 --
 drivers/gpu/drm/sti/sti_hda.c            | 1 -
 drivers/gpu/drm/sti/sti_hdmi.c           | 1 -
 4 files changed, 6 deletions(-)

-- 
2.11.0
