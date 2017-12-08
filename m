From: smitha.t@samsung.com (Smitha T Murthy)
Date: Fri, 08 Dec 2017 14:38:19 +0530
Subject: [Patch v6 06/12] [media] v4l2-ioctl: add HEVC format description
In-Reply-To: <1512724105-1778-1-git-send-email-smitha.t@samsung.com>
References: <1512724105-1778-1-git-send-email-smitha.t@samsung.com>
 <CGME20171208093652epcas1p284476d0cff4b03af0a79aa416445b2a5@epcas1p2.samsung.com>
Message-ID: <1512724105-1778-7-git-send-email-smitha.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HEVC is a video coding format

Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 7961499..8a3c6a8 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1268,6 +1268,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_VC1_ANNEX_L:	descr = "VC-1 (SMPTE 412M Annex L)"; break;
 		case V4L2_PIX_FMT_VP8:		descr = "VP8"; break;
 		case V4L2_PIX_FMT_VP9:		descr = "VP9"; break;
+		case V4L2_PIX_FMT_HEVC:		descr = "HEVC"; break; /* aka H.265 */
 		case V4L2_PIX_FMT_CPIA1:	descr = "GSPCA CPiA YUV"; break;
 		case V4L2_PIX_FMT_WNVA:		descr = "WNVA"; break;
 		case V4L2_PIX_FMT_SN9C10X:	descr = "GSPCA SN9C10X"; break;
-- 
2.7.4
