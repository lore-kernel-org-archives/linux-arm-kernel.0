From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue,  9 Sep 2014 18:50:59 +0200
Subject: [PATCH v3 2/7] arm: multi_v7_defconfig: Enable Mediatek platform
In-Reply-To: <1410281464-9587-1-git-send-email-matthias.bgg@gmail.com>
References: <1410281464-9587-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1410281464-9587-3-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Mediatek platform support for multi_v7_defconfig.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fb95fb..4c08101 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -42,6 +42,7 @@ CONFIG_SOC_AM33XX=y
 CONFIG_SOC_AM43XX=y
 CONFIG_SOC_DRA7XX=y
 CONFIG_ARCH_QCOM=y
+CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MSM8X60=y
 CONFIG_ARCH_MSM8960=y
 CONFIG_ARCH_MSM8974=y
-- 
1.9.1
