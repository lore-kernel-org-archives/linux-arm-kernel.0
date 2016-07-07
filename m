From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 7 Jul 2016 15:37:07 +0800
Subject: [PATCH v3 0/2] drm/mediatek: MT8173 gamma & dither support 
Message-ID: <1467877029-45236-1-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is MT8173 gamma & dither support PATCH v3, based on 4.7-rc1.

Changes since v2:
 -Modify defines to match the register field names in the MT8173 datasheet
 -Made dithering function support hardware mirroring well on two  monitor.

Bibby Hsieh (2):
  drm/mediatek: Add gamma correction
  drm/mediatek: set mt8173 dithering function

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |    3 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |    3 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   29 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |    1 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  154 +++++++++++++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   16 ++-
 6 files changed, 192 insertions(+), 14 deletions(-)

-- 
1.7.9.5
