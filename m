From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Wed,  2 Aug 2017 11:19:43 +0800
Subject: [PATCH v5 2/6] extended-controls.rst: add PorterDuff mode control
In-Reply-To: <1501643987-27847-1-git-send-email-jacob-chen@iotwrt.com>
References: <1501643987-27847-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1501643987-27847-3-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PorterDuff mode control are used to determine
how two images are combined.

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 Documentation/media/uapi/v4l/extended-controls.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
index abb1057..b713581 100644
--- a/Documentation/media/uapi/v4l/extended-controls.rst
+++ b/Documentation/media/uapi/v4l/extended-controls.rst
@@ -3021,6 +3021,11 @@ Image Process Control IDs
     The video deinterlacing mode (such as Bob, Weave, ...). The menu items are
     driver specific and are documented in :ref:`v4l-drivers`.
 
+``V4L2_CID_PORTER_DUFF_MODE (menu)``
+    The PorterDuff blend modes. PorterDuff is a method to overlay, combine and
+    trim images as if they were pieces of cardboard. The device uses this to
+    determine how two images are combined. For more information see
+    `PorterDuff.Mode <https://developer.android.com/reference/android/graphics/PorterDuff.Mode.html>`__.
 
 .. _dv-controls:
 
-- 
2.7.4
