From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 31 May 2017 13:58:47 +0300
Subject: [PATCH 05/10] staging: fsl-mc: remove extra blank line
In-Reply-To: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
References: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
Message-ID: <20170531105852.22304-6-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Remove extra blank line reported by checkpatch.pl.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/include/dprc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/include/dprc.h b/drivers/staging/fsl-mc/include/dprc.h
index 8498a5e..2f4a7a7 100644
--- a/drivers/staging/fsl-mc/include/dprc.h
+++ b/drivers/staging/fsl-mc/include/dprc.h
@@ -49,7 +49,6 @@ int dprc_close(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token);
 
-
 /* IRQ */
 
 /* IRQ index */
-- 
2.9.4
