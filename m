From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Wed, 10 Aug 2016 22:48:48 +0800
Subject: [PATCH v4 3/9] docs-rst: Add compressed video formats used on MT8173
 codec driver
In-Reply-To: <1470840534-4788-3-git-send-email-tiffany.lin@mediatek.com>
References: <1470840534-4788-1-git-send-email-tiffany.lin@mediatek.com>
 <1470840534-4788-2-git-send-email-tiffany.lin@mediatek.com>
 <1470840534-4788-3-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1470840534-4788-4-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add V4L2_PIX_FMT_MT21C documentation

Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 Documentation/media/uapi/v4l/pixfmt-reserved.rst |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/media/uapi/v4l/pixfmt-reserved.rst b/Documentation/media/uapi/v4l/pixfmt-reserved.rst
index 9a5704b..041ceaf 100644
--- a/Documentation/media/uapi/v4l/pixfmt-reserved.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-reserved.rst
@@ -337,6 +337,13 @@ please make a proposal on the linux-media mailing list.
 	  array. Anything what's in between the UYVY lines is JPEG data and
 	  should be concatenated to form the JPEG stream.
 
+    -  .. _V4L2-PIX-FMT-MT21C:
+
+       -  ``V4L2_PIX_FMT_MT21C``
+
+       -  'MT21'
+
+       -  Compressed two-planar YVU420 format used by Mediatek MT8173.
 
 
 .. _format-flags:
-- 
1.7.9.5
