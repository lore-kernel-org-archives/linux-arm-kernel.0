From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Fri, 2 Sep 2016 20:19:59 +0800
Subject: [PATCH v5 8/9] Add documentation for V4L2_PIX_FMT_VP9.
In-Reply-To: <1472818800-22558-8-git-send-email-tiffany.lin@mediatek.com>
References: <1472818800-22558-1-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-2-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-3-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-4-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-5-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-6-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-7-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-8-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1472818800-22558-9-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for V4L2_PIX_FMT_VP9.

Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
Signed-off-by: Wu-Cheng Li <wuchengli@chromium.org>
---
 Documentation/media/uapi/v4l/pixfmt-013.rst |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/media/uapi/v4l/pixfmt-013.rst b/Documentation/media/uapi/v4l/pixfmt-013.rst
index bfef4f4..58e3ce6 100644
--- a/Documentation/media/uapi/v4l/pixfmt-013.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-013.rst
@@ -129,3 +129,11 @@ Compressed Formats
        -  'VP80'
 
        -  VP8 video elementary stream.
+
+    -  .. _V4L2-PIX-FMT-VP9:
+
+       -  ``V4L2_PIX_FMT_VP9``
+
+       -  'VP90'
+
+       -  VP9 video elementary stream.
-- 
1.7.9.5
