From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Mon, 31 Jul 2017 23:32:58 +0800
Subject: [PATCH v4 2/6] [media] extended-controls.rst: add PorterDuff mode
 control
In-Reply-To: <1501515182-26705-1-git-send-email-jacob-chen@iotwrt.com>
References: <1501515182-26705-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1501515182-26705-3-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PorterDuff mode control are used to determine
how two images are combined.

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 Documentation/media/uapi/v4l/extended-controls.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
index abb1057..f9c93bb 100644
--- a/Documentation/media/uapi/v4l/extended-controls.rst
+++ b/Documentation/media/uapi/v4l/extended-controls.rst
@@ -3021,6 +3021,10 @@ Image Process Control IDs
     The video deinterlacing mode (such as Bob, Weave, ...). The menu items are
     driver specific and are documented in :ref:`v4l-drivers`.
 
+``V4L2_CID_PORTER_DUFF_MODE (menu)``
+    The PorterDuff blend modes. PorterDuff is way to overlay, combine and
+    trim images as if they were pieces of cardboard, device could use to
+    determine how two images are combined.
 
 .. _dv-controls:
 
-- 
2.7.4
