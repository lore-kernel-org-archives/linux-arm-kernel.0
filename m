From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 02 Jul 2010 09:29:34 -0600
Subject: [PATCH 13/20] OMAP: hwmod data: add class for IVA hwmods
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Message-ID: <20100702152932.6221.98446.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@deeprootsystems.com>

Add a new hwmod class for IVA devices.  To be used when hwmods
are created for IVA2 on OMAP3.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_common_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_common_data.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
index 1e80b91..08a1342 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -66,3 +66,6 @@ struct omap_hwmod_class mpu_hwmod_class = {
 	.name = "mpu"
 };
 
+struct omap_hwmod_class iva_hwmod_class = {
+	.name = "iva"
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index 3645a28..c34e98b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -20,5 +20,6 @@
 extern struct omap_hwmod_class l3_hwmod_class;
 extern struct omap_hwmod_class l4_hwmod_class;
 extern struct omap_hwmod_class mpu_hwmod_class;
+extern struct omap_hwmod_class iva_hwmod_class;
 
 #endif
