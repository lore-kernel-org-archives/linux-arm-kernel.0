From: smitha.t@samsung.com (Smitha T Murthy)
Date: Fri, 08 Dec 2017 14:38:18 +0530
Subject: [Patch v6 05/12] [media] videodev2.h: Add v4l2 definition for HEVC
In-Reply-To: <1512724105-1778-1-git-send-email-smitha.t@samsung.com>
References: <1512724105-1778-1-git-send-email-smitha.t@samsung.com>
 <CGME20171208093649epcas1p1a4079fba04eb53bc9249a35361746ea9@epcas1p1.samsung.com>
Message-ID: <1512724105-1778-6-git-send-email-smitha.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add V4L2 definition for HEVC compressed format

Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 include/uapi/linux/videodev2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 185d6a0..bd9b5d5 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -634,6 +634,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_VC1_ANNEX_L v4l2_fourcc('V', 'C', '1', 'L') /* SMPTE 421M Annex L compliant stream */
 #define V4L2_PIX_FMT_VP8      v4l2_fourcc('V', 'P', '8', '0') /* VP8 */
 #define V4L2_PIX_FMT_VP9      v4l2_fourcc('V', 'P', '9', '0') /* VP9 */
+#define V4L2_PIX_FMT_HEVC     v4l2_fourcc('H', 'E', 'V', 'C') /* HEVC aka H.265 */
 
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
-- 
2.7.4
