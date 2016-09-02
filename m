From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Fri, 2 Sep 2016 20:19:57 +0800
Subject: [PATCH v5 6/9] videodev2.h: add V4L2_PIX_FMT_VP9 format.
In-Reply-To: <1472818800-22558-6-git-send-email-tiffany.lin@mediatek.com>
References: <1472818800-22558-1-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-2-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-3-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-4-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-5-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-6-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1472818800-22558-7-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wu-Cheng Li <wuchengli@chromium.org>

This adds VP9 video coding format, a successor to VP8.

Signed-off-by: Wu-Cheng Li <wuchengli@chromium.org>
Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 include/uapi/linux/videodev2.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 5529741..43326c3 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -603,6 +603,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_VC1_ANNEX_G v4l2_fourcc('V', 'C', '1', 'G') /* SMPTE 421M Annex G compliant stream */
 #define V4L2_PIX_FMT_VC1_ANNEX_L v4l2_fourcc('V', 'C', '1', 'L') /* SMPTE 421M Annex L compliant stream */
 #define V4L2_PIX_FMT_VP8      v4l2_fourcc('V', 'P', '8', '0') /* VP8 */
+#define V4L2_PIX_FMT_VP9      v4l2_fourcc('V', 'P', '9', '0') /* VP9 */
 
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
-- 
1.7.9.5
