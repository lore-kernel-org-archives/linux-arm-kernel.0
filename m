From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 10 Mar 2011 14:03:11 +0100
Subject: [PATCH v4 1/3] ARM: S5P: Rename MIPI-CSIS driver header and update
	Copyright
In-Reply-To: <1299762193-7791-1-git-send-email-s.nawrocki@samsung.com>
References: <1299762193-7791-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1299762193-7791-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-s5p/dev-csis0.c                      |    2 +-
 arch/arm/plat-s5p/dev-csis1.c                      |    2 +-
 .../plat-s5p/include/plat/{csis.h => mipi_csis.h}  |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm/plat-s5p/include/plat/{csis.h => mipi_csis.h} (67%)

diff --git a/arch/arm/plat-s5p/dev-csis0.c b/arch/arm/plat-s5p/dev-csis0.c
index dfab1c8..e3aabef 100644
--- a/arch/arm/plat-s5p/dev-csis0.c
+++ b/arch/arm/plat-s5p/dev-csis0.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010 Samsung Electronics
+ * Copyright (C) 2010-2011 Samsung Electronics Co., Ltd.
  *
  * S5P series device definition for MIPI-CSIS channel 0
  *
diff --git a/arch/arm/plat-s5p/dev-csis1.c b/arch/arm/plat-s5p/dev-csis1.c
index e3053f2..08b91b5 100644
--- a/arch/arm/plat-s5p/dev-csis1.c
+++ b/arch/arm/plat-s5p/dev-csis1.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010 Samsung Electronics
+ * Copyright (C) 2010-2011 Samsung Electronics Co., Ltd.
  *
  * S5P series device definition for MIPI-CSIS channel 1
  *
diff --git a/arch/arm/plat-s5p/include/plat/csis.h b/arch/arm/plat-s5p/include/plat/mipi_csis.h
similarity index 67%
rename from arch/arm/plat-s5p/include/plat/csis.h
rename to arch/arm/plat-s5p/include/plat/mipi_csis.h
index 51e308c..8b3ada8 100644
--- a/arch/arm/plat-s5p/include/plat/csis.h
+++ b/arch/arm/plat-s5p/include/plat/mipi_csis.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010 Samsung Electronics
+ * Copyright (C) 2010-2011 Samsung Electronics Co., Ltd.
  *
  * S5P series MIPI CSI slave device support
  *
@@ -8,11 +8,11 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef PLAT_S5P_CSIS_H_
-#define PLAT_S5P_CSIS_H_ __FILE__
+#ifndef PLAT_S5P_MIPI_CSIS_H_
+#define PLAT_S5P_MIPI_CSIS_H_ __FILE__
 
 /**
- * struct s5p_platform_mipi_csis - platform data for MIPI-CSIS
+ * struct s5p_platform_mipi_csis - platform data for S5P MIPI-CSIS driver
  * @clk_rate: bus clock frequency
  * @lanes: number of data lanes used
  * @alignment: data alignment in bits
@@ -25,4 +25,4 @@ struct s5p_platform_mipi_csis {
 	u8 hs_settle;
 };
 
-#endif /* PLAT_S5P_CSIS_H_ */
+#endif /* PLAT_S5P_MIPI_CSIS_H_ */
-- 
1.7.4.1
