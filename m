From: smitha.t@samsung.com (Smitha T Murthy)
Date: Fri, 08 Dec 2017 14:38:20 +0530
Subject: [Patch v6 07/12] Documentation: v4l: Documentation for HEVC v4l2
 definition
In-Reply-To: <1512724105-1778-1-git-send-email-smitha.t@samsung.com>
References: <1512724105-1778-1-git-send-email-smitha.t@samsung.com>
 <CGME20171208093654epcas2p23b6b9666cbd85b3b72c139b172810947@epcas2p2.samsung.com>
Message-ID: <1512724105-1778-8-git-send-email-smitha.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add V4L2 definition for HEVC compressed format which is also
known as H.265.

Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 Documentation/media/uapi/v4l/pixfmt-compressed.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/media/uapi/v4l/pixfmt-compressed.rst b/Documentation/media/uapi/v4l/pixfmt-compressed.rst
index 728d7ed..abec039 100644
--- a/Documentation/media/uapi/v4l/pixfmt-compressed.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-compressed.rst
@@ -90,3 +90,8 @@ Compressed Formats
       - ``V4L2_PIX_FMT_VP9``
       - 'VP90'
       - VP9 video elementary stream.
+    * .. _V4L2-PIX-FMT-HEVC:
+
+      - ``V4L2_PIX_FMT_HEVC``
+      - 'HEVC'
+      - HEVC/H.265 video elementary stream.
-- 
2.7.4
