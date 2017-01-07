From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Fri,  6 Jan 2017 18:11:32 -0800
Subject: [PATCH v3 14/24] UAPI: Add media UAPI Kbuild file
In-Reply-To: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1483755102-24785-15-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an empty UAPI Kbuild file for media UAPI headers.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 include/uapi/Kbuild       | 1 +
 include/uapi/media/Kbuild | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 include/uapi/media/Kbuild

diff --git a/include/uapi/Kbuild b/include/uapi/Kbuild
index 245aa6e..9a51957 100644
--- a/include/uapi/Kbuild
+++ b/include/uapi/Kbuild
@@ -6,6 +6,7 @@
 header-y += asm-generic/
 header-y += linux/
 header-y += sound/
+header-y += media/
 header-y += mtd/
 header-y += rdma/
 header-y += video/
diff --git a/include/uapi/media/Kbuild b/include/uapi/media/Kbuild
new file mode 100644
index 0000000..aafaa5a
--- /dev/null
+++ b/include/uapi/media/Kbuild
@@ -0,0 +1 @@
+# UAPI Header export list
-- 
2.7.4
