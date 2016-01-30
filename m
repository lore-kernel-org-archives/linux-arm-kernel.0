From: ayaka@soulik.info (ayaka)
Date: Sun, 31 Jan 2016 02:53:37 +0800
Subject: [PATCH 4/4] [media] s5p-mfc: fix a typo in s5p_mfc_dec
In-Reply-To: <1454180017-29071-1-git-send-email-ayaka@soulik.info>
References: <1454180017-29071-1-git-send-email-ayaka@soulik.info>
Message-ID: <1454180017-29071-5-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is a cosmetic commit.

Signed-off-by: ayaka <ayaka@soulik.info>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index 609b17b..cfedf89 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -572,7 +572,7 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
 
 	if (reqbufs->memory != V4L2_MEMORY_MMAP) {
-		mfc_err("Only V4L2_MEMORY_MAP is supported\n");
+		mfc_err("Only V4L2_MEMORY_MMAP is supported\n");
 		return -EINVAL;
 	}
 
-- 
2.5.0
