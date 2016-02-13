From: jchandra@broadcom.com (Jayachandran C)
Date: Sun, 14 Feb 2016 00:16:34 +0530
Subject: [PATCH 3/4] arm64: defconfig: Add Broadcom Vulcan to defconfig
In-Reply-To: <1455389195-31870-1-git-send-email-jchandra@broadcom.com>
References: <1455389195-31870-1-git-send-email-jchandra@broadcom.com>
Message-ID: <1455389195-31870-4-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Broadcom Vulcan support in arm64 default configuration. This will
build the device tree needed to boot on a Broadcom Vulcan board.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 86581f7..6c1b3a6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -47,6 +47,7 @@ CONFIG_ARCH_SPRD=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_UNIPHIER=y
 CONFIG_ARCH_VEXPRESS=y
+CONFIG_ARCH_VULCAN=y
 CONFIG_ARCH_XGENE=y
 CONFIG_ARCH_ZYNQMP=y
 CONFIG_PCI=y
-- 
1.9.1
