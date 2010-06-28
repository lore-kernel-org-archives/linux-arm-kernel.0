From: p.osciak@samsung.com (Pawel Osciak)
Date: Mon, 28 Jun 2010 10:08:53 +0200
Subject: [PATCH v3 07/12] s3c-fb: window 3 of 64xx+ does not have an osd_d
	register
In-Reply-To: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
Message-ID: <1277712538-23188-8-git-send-email-p.osciak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/s3c-fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 6131ebb..0a93fca 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1437,7 +1437,6 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] __devinitdata = {
 	},
 	[3] = {
 		.has_osd_c	= 1,
-		.has_osd_d	= 1,
 		.palette_sz	= 16,
 		.palette_16bpp	= 1,
 		.valid_bpp	= (VALID_BPP124  | VALID_BPP(16) |
-- 
1.7.1.569.g6f426
