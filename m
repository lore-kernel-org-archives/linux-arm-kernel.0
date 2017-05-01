From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 1 May 2017 17:30:13 -0400
Subject: [PATCH v3 11/11] fsl/soc/qbman: Enable FSL_LAYERSCAPE config on ARM
In-Reply-To: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
References: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1493674213-963-12-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Madalin Bucur <madalin.bucur@nxp.com>

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
[Stuart: changed to use ARCH_LAYERSCAPE]
Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/Kconfig b/drivers/soc/fsl/qbman/Kconfig
index 757033c..fb4e6bf 100644
--- a/drivers/soc/fsl/qbman/Kconfig
+++ b/drivers/soc/fsl/qbman/Kconfig
@@ -1,6 +1,6 @@
 menuconfig FSL_DPAA
 	bool "Freescale DPAA 1.x support"
-	depends on FSL_SOC_BOOKE
+	depends on (FSL_SOC_BOOKE || ARCH_LAYERSCAPE)
 	select GENERIC_ALLOCATOR
 	help
 	  The Freescale Data Path Acceleration Architecture (DPAA) is a set of
-- 
2.7.4
