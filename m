From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon,  8 Feb 2016 10:11:39 +0100
Subject: [PATCH 3/3] arm64: defconfig: enable the Alpine family
In-Reply-To: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1454922699-16785-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Alpine SoC family in the arm64 defconfig.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 18ca9fb9e65f..10387947a164 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -31,6 +31,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_EXYNOS7=y
-- 
2.7.0
