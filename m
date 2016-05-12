From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Thu, 12 May 2016 19:24:03 +0800
Subject: [PATCH v2 2/9] [media] : v4l: add Mediatek compressed video block
 format
In-Reply-To: <1463052250-38262-2-git-send-email-tiffany.lin@mediatek.com>
References: <1463052250-38262-1-git-send-email-tiffany.lin@mediatek.com>
 <1463052250-38262-2-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1463052250-38262-3-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add V4L2_PIX_FMT_MT21 format used on MT8173 driver.
It is compressed format and need MT8173 MDP driver to transfer to other 
standard format.

Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 include/uapi/linux/videodev2.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 8f95191..52feea6 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -625,6 +625,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_Y8I      v4l2_fourcc('Y', '8', 'I', ' ') /* Greyscale 8-bit L/R interleaved */
 #define V4L2_PIX_FMT_Y12I     v4l2_fourcc('Y', '1', '2', 'I') /* Greyscale 12-bit L/R interleaved */
 #define V4L2_PIX_FMT_Z16      v4l2_fourcc('Z', '1', '6', ' ') /* Depth data 16-bit */
+#define V4L2_PIX_FMT_MT21     v4l2_fourcc('M', 'T', '2', '1') /* Mediatek compressed block mode  */
 
 /* SDR formats - used only for Software Defined Radio devices */
 #define V4L2_SDR_FMT_CU8          v4l2_fourcc('C', 'U', '0', '8') /* IQ u8 */
-- 
1.7.9.5
