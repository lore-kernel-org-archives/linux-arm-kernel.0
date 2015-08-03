From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  3 Aug 2015 21:24:46 +0200
Subject: [PATCH 2/2] arm64: Enable Marvell Berlin SoC family in defconfig
In-Reply-To: <1438629886-6390-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1438629886-6390-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1438629886-6390-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>

Enable Marvell Berlin SoC family in arm64 defconfig.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Also discussed with Olof on IRC, this is the defconfig changes singled
out from Jisheng's original patch.

Sebastian
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f38c94f1d898..9e8978c35772 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -31,6 +31,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_EXYNOS7=y
 CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_ARCH_HISI=y
-- 
2.1.0
