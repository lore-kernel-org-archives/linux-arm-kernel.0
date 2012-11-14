From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 15 Nov 2012 00:37:59 +0530
Subject: [PATCH V5 6/7] ARM: OMAP2+: omap2plus_defconfig: Enable CPSW support
In-Reply-To: <1352920080-6179-1-git-send-email-mugunthanvnm@ti.com>
References: <1352920080-6179-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <1352920080-6179-7-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CPSW support in defconfig which is present in AM33xx SoC

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
---
 arch/arm/configs/omap2plus_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a4b330e..41b595e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -242,3 +242,6 @@ CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_LIBCRC32C=y
 CONFIG_SOC_OMAP5=y
+CONFIG_TI_DAVINCI_MDIO=y
+CONFIG_TI_DAVINCI_CPDMA=y
+CONFIG_TI_CPSW=y
-- 
1.7.0.4
