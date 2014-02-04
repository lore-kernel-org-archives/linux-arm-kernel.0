From: amit.grover@samsung.com (Amit Grover)
Date: Tue, 04 Feb 2014 15:29:57 +0530
Subject: [PATCH v3 0/2] drivers/media: Add controls for Horizontal and Vertical
 MV Search Range
In-Reply-To: <52E0ED10.2020901@samsung.com>
References: <52E0ED10.2020901@samsung.com>
Message-ID: <1391507999-31437-1-git-send-email-amit.grover@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v3 version for the patch:
s5p-mfc: Add Horizontal and Vertical search range for Video Macro Blocks
(https://lkml.org/lkml/2013/12/30/83)

Changes from v1:
1) Splitted the patch into V4L2 and MFC driver patches.
2) Incorporated review comments on v1.

Changes from v2:
1) Removed the range restrictions from drivers/media/v4l2-core/v4l2-ctrls.c.
2) Rebased the patch to git://linuxtv.org/mchehab/media-next.git.
3) Added [media] tag in title.

Amit Grover (2):
  [media] v4l2: Add settings for Horizontal and Vertical MV Search
    Range
  [media] s5p-mfc: Add Horizontal and Vertical MV Search Range

 Documentation/DocBook/media/v4l/controls.xml    |   20 +++++++++++++++++++
 drivers/media/platform/s5p-mfc/regs-mfc-v6.h    |    1 +
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h |    2 ++
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c    |   24 +++++++++++++++++++++++
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c |    8 ++------
 drivers/media/v4l2-core/v4l2-ctrls.c            |    6 ++++++
 include/uapi/linux/v4l2-controls.h              |    2 ++
 7 files changed, 57 insertions(+), 6 deletions(-)

-- 
1.7.9.5
