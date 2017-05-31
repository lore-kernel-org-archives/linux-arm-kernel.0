From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 31 May 2017 13:58:48 +0300
Subject: [PATCH 06/10] staging: fsl-mc: drop unused forward declaration
In-Reply-To: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
References: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
Message-ID: <20170531105852.22304-7-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This forward declaration of "struct fsl_mc_resource"
is of no use so drop it.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/include/mc-sys.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/include/mc-sys.h b/drivers/staging/fsl-mc/include/mc-sys.h
index dca7f90..b520370 100644
--- a/drivers/staging/fsl-mc/include/mc-sys.h
+++ b/drivers/staging/fsl-mc/include/mc-sys.h
@@ -46,7 +46,6 @@
  */
 #define FSL_MC_IO_ATOMIC_CONTEXT_PORTAL	0x0001
 
-struct fsl_mc_resource;
 struct mc_command;
 
 /**
-- 
2.9.4
