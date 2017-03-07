From: wuchengli@chromium.org (Wu-Cheng Li)
Date: Tue,  7 Mar 2017 14:03:27 +0800
Subject: [PATCH v1 0/1] mtk-vcodec: check the vp9 decoder buffer index from VPU
Message-ID: <20170307060328.114348-1-wuchengli@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wu-Cheng Li <wuchengli@google.com>

This patch guards against the invalid buffer index from
VPU firmware.

Wu-Cheng Li (1):
  mtk-vcodec: check the vp9 decoder buffer index from VPU.

 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c |  6 +++++
 .../media/platform/mtk-vcodec/vdec/vdec_vp9_if.c   | 26 ++++++++++++++++++++++
 drivers/media/platform/mtk-vcodec/vdec_drv_if.h    |  2 ++
 3 files changed, 34 insertions(+)

-- 
2.12.0.rc1.440.g5b76565f74-goog
