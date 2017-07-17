From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Mon, 17 Jul 2017 16:26:40 +0300
Subject: [PATCH 1/7] staging: fsl-mc: add missing fsl_mc comment in struct
 msi_desc
In-Reply-To: <20170717132646.3020-1-laurentiu.tudor@nxp.com>
References: <20170717132646.3020-1-laurentiu.tudor@nxp.com>
Message-ID: <20170717132646.3020-2-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The mc-bus specific field, fsl_mc in struct msi_desc is missing its
comment so add it.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 include/linux/msi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index df6d592..80e3b56 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -66,6 +66,7 @@ struct fsl_mc_msi_desc {
  * @mask_pos:	[PCI MSI]   Mask register position
  * @mask_base:	[PCI MSI-X] Mask register base address
  * @platform:	[platform]  Platform device specific msi descriptor data
+ * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
-- 
2.9.4
