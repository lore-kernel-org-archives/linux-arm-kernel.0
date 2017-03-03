From: smitha.t@samsung.com (Smitha T Murthy)
Date: Fri, 03 Mar 2017 14:37:10 +0530
Subject: [Patch v2 05/11] videodev2.h: Add v4l2 definition for HEVC
In-Reply-To: <1488532036-13044-1-git-send-email-smitha.t@samsung.com>
References: <1488532036-13044-1-git-send-email-smitha.t@samsung.com>
 <CGME20170303090449epcas5p3adcab3282b760d01ccb775bbd95c57f5@epcas5p3.samsung.com>
Message-ID: <1488532036-13044-6-git-send-email-smitha.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add V4L2 definition for HEVC compressed format

Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 include/uapi/linux/videodev2.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 46e8a2e3..620e941 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -630,6 +630,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_VC1_ANNEX_L v4l2_fourcc('V', 'C', '1', 'L') /* SMPTE 421M Annex L compliant stream */
 #define V4L2_PIX_FMT_VP8      v4l2_fourcc('V', 'P', '8', '0') /* VP8 */
 #define V4L2_PIX_FMT_VP9      v4l2_fourcc('V', 'P', '9', '0') /* VP9 */
+#define V4L2_PIX_FMT_HEVC     v4l2_fourcc('H', 'E', 'V', 'C') /* HEVC */
 
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
-- 
1.7.2.3
