From: smitha.t@samsung.com (Smitha T Murthy)
Date: Fri, 03 Mar 2017 14:37:12 +0530
Subject: [Patch v2 07/11] Documentation: v4l: Documentation for HEVC v4l2
 definition
In-Reply-To: <1488532036-13044-1-git-send-email-smitha.t@samsung.com>
References: <1488532036-13044-1-git-send-email-smitha.t@samsung.com>
 <CGME20170303090459epcas5p4498e5a633739ef3829ba1fccd79f6821@epcas5p4.samsung.com>
Message-ID: <1488532036-13044-8-git-send-email-smitha.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add V4L2 definition for HEVC compressed format

Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 Documentation/media/uapi/v4l/pixfmt-013.rst |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/media/uapi/v4l/pixfmt-013.rst b/Documentation/media/uapi/v4l/pixfmt-013.rst
index 728d7ed..ff4cac2 100644
--- a/Documentation/media/uapi/v4l/pixfmt-013.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-013.rst
@@ -90,3 +90,8 @@ Compressed Formats
       - ``V4L2_PIX_FMT_VP9``
       - 'VP90'
       - VP9 video elementary stream.
+    * .. _V4L2-PIX-FMT-HEVC:
+
+      - ``V4L2_PIX_FMT_HEVC``
+      - 'HEVC'
+      - HEVC video elementary stream.
-- 
1.7.2.3
