From: roy.pledge@nxp.com (Roy Pledge)
Date: Wed, 18 Jan 2017 17:39:40 -0500
Subject: [PATCH 10/10] fsl/qbman: Enable FSL_LAYERSCAPE config on ARM
In-Reply-To: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1484779180-1344-11-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Madalin Bucur <madalin.bucur@nxp.com>

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
[Stuart: changed to use ARCH_LAYERSCAPE]
Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
---
 drivers/soc/fsl/qbman/Kconfig |    2 +-
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
1.7.9.5
