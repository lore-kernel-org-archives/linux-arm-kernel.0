From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 7 Feb 2017 08:15:29 -0600
Subject: [PATCH 09/10] staging: fsl-mc: dpbp: add a few missing
 EXPORT_SYMBOL()s
In-Reply-To: <20170207141530.12979-1-laurentiu.tudor@nxp.com>
References: <20170207141530.12979-1-laurentiu.tudor@nxp.com>
Message-ID: <20170207141530.12979-10-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpbp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/staging/fsl-mc/bus/dpbp.c
index 1fa7257..d9e450a 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/staging/fsl-mc/bus/dpbp.c
@@ -183,6 +183,7 @@ int dpbp_is_enabled(struct fsl_mc_io *mc_io,
 
 	return 0;
 }
+EXPORT_SYMBOL(dpbp_is_enabled);
 
 /**
  * dpbp_reset() - Reset the DPBP, returns the object to initial state.
@@ -205,6 +206,7 @@ int dpbp_reset(struct fsl_mc_io *mc_io,
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
 }
+EXPORT_SYMBOL(dpbp_reset);
 
 /**
  * dpbp_get_attributes - Retrieve DPBP attributes.
@@ -274,3 +276,4 @@ int dpbp_get_api_version(struct fsl_mc_io *mc_io,
 
 	return 0;
 }
+EXPORT_SYMBOL(dpbp_get_api_version);
-- 
1.8.3.1
