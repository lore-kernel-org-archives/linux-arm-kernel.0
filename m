From: rric@kernel.org (Robert Richter)
Date: Wed, 30 Jul 2014 17:06:33 +0200
Subject: [PATCH 4/5] arm64, defconfig: Enable Cavium Thunder SoC in defconfig
In-Reply-To: <1406732794-20920-1-git-send-email-rric@kernel.org>
References: <1406732794-20920-1-git-send-email-rric@kernel.org>
Message-ID: <1406732794-20920-5-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch enables Thunder SoCs in the arm64 defconfig. This is
esp. useful to add Thunder platforms to automated builds based on
arm64 defconfig.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3421f316f5dc..26c3ab582db5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -32,6 +32,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
 CONFIG_SMP=y
-- 
2.0.1
