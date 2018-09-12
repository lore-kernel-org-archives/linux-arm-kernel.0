From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Wed, 12 Sep 2018 14:02:49 +0800
Subject: [PATCH v1 0/1] Add function to set the possible crtc for connector
Message-ID: <1536732170-30046-1-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the function for connector driver(dpi or dsi) to set the
possible crtc.

The connector associated which crtc is depend on the ddp_path.

Stu Hsieh (1):
  drm/mediatek: add function to match the connector and crtc

 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 41 +++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  2 ++
 2 files changed, 43 insertions(+)

-- 
2.12.5.2.gbdf23ab
