From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Fri, 21 Oct 2016 11:59:18 -0200
Subject: [PATCH 3/4] mtk_mdp_m2m: remove an unused struct
In-Reply-To: <cd14afdb178cf490e257368bc899c7a0c690d140.1477058332.git.mchehab@s-opensource.com>
References: <cd14afdb178cf490e257368bc899c7a0c690d140.1477058332.git.mchehab@s-opensource.com>
Message-ID: <624b0ea4550b90318ec2293d80b1caa5bafd2a35.1477058332.git.mchehab@s-opensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c:48:33: warning: ?mtk_mdp_size_align? defined but not used [-Wunused-variable]
 static struct mtk_mdp_pix_align mtk_mdp_size_align = {
                                 ^~~~~~~~~~~~~~~~~~

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
index 065502757133..33124a6c9951 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
@@ -45,13 +45,6 @@ struct mtk_mdp_pix_limit {
 	u16 target_rot_en_h;
 };
 
-static struct mtk_mdp_pix_align mtk_mdp_size_align = {
-	.org_w			= 16,
-	.org_h			= 16,
-	.target_w		= 2,
-	.target_h		= 2,
-};
-
 static const struct mtk_mdp_fmt mtk_mdp_formats[] = {
 	{
 		.pixelformat	= V4L2_PIX_FMT_NV12M,
-- 
2.7.4
