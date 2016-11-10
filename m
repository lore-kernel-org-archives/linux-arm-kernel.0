From: wuchengli@chromium.org (Wu-Cheng Li)
Date: Thu, 10 Nov 2016 13:24:04 +0800
Subject: [PATCH v1] mtk-vcodec: add index check in decoder vidioc_qbuf
Message-ID: <1478755445-23494-1-git-send-email-wuchengli@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wu-Cheng Li <wuchengli@google.com>

This patch adds a buffer index check in decoder vidioc_qbuf.

Wu-Cheng Li (1):
  mtk-vcodec: add index check in decoder vidioc_qbuf.

 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.8.0.rc3.226.g39d4020
