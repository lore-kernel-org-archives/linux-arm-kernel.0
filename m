From: wuchengli@chromium.org (Wu-Cheng Li)
Date: Thu, 14 Jan 2016 22:50:05 +0800
Subject: [PATCH v3 0/2] new control V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME
Message-ID: <1452783007-80883-1-git-send-email-wuchengli@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3 addressed Hans' comment to remove the name of the control in s5p-mfc.

Wu-Cheng Li (2):
  v4l: add V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME.
  s5p-mfc: add the support of V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME.

 Documentation/DocBook/media/v4l/controls.xml |  8 ++++++++
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 12 ++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls.c         |  2 ++
 include/uapi/linux/v4l2-controls.h           |  1 +
 4 files changed, 23 insertions(+)

-- 
2.6.0.rc2.230.g3dd15c0
