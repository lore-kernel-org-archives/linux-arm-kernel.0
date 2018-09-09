From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun,  9 Sep 2018 21:10:13 +0200
Subject: [PATCH v2 2/4] media: cedrus: Add TODO file with tasks to complete
 before unstaging
In-Reply-To: <20180909191015.20902-1-contact@paulk.fr>
References: <20180909191015.20902-1-contact@paulk.fr>
Message-ID: <20180909191015.20902-3-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the elements listed are complete, the Cedrus driver will be ready
to move out of the staging area of the kernel.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/staging/media/sunxi/cedrus/TODO | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 drivers/staging/media/sunxi/cedrus/TODO

diff --git a/drivers/staging/media/sunxi/cedrus/TODO b/drivers/staging/media/sunxi/cedrus/TODO
new file mode 100644
index 000000000000..ec277ece47af
--- /dev/null
+++ b/drivers/staging/media/sunxi/cedrus/TODO
@@ -0,0 +1,7 @@
+Before this stateless decoder driver can leave the staging area:
+* The Request API needs to be stabilized;
+* The codec-specific controls need to be thoroughly reviewed to ensure they
+  cover all intended uses cases;
+* Userspace support for the Request API needs to be reviewed;
+* Another stateless decoder driver should be submitted;
+* At least one stateless encoder driver should be submitted.
-- 
2.18.0
