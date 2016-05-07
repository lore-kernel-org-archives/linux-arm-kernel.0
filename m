From: ayaka@soulik.info (ayaka)
Date: Sat,  7 May 2016 13:05:26 +0800
Subject: [PATCH 3/3] [media] s5p-mfc: fix a typo in s5p_mfc_dec
In-Reply-To: <1462597526-31559-1-git-send-email-ayaka@soulik.info>
References: <1462597526-31559-1-git-send-email-ayaka@soulik.info>
Message-ID: <1462597526-31559-4-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is a cosmetic commit.

Signed-off-by: ayaka <ayaka@soulik.info>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index f2d6376..391ed9c 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -573,7 +573,7 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
 
 	if (reqbufs->memory != V4L2_MEMORY_MMAP) {
-		mfc_err("Only V4L2_MEMORY_MAP is supported\n");
+		mfc_err("Only V4L2_MEMORY_MMAP is supported\n");
 		return -EINVAL;
 	}
 
-- 
2.5.5
