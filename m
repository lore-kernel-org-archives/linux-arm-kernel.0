From: jnair@caviumnetworks.com (Jayachandran C)
Date: Mon, 22 May 2017 07:36:05 +0000
Subject: [PATCH 2/2] arm64: defconfig: drop ARCH_VULCAN
In-Reply-To: <1495438565-82495-1-git-send-email-jnair@caviumnetworks.com>
References: <1495438565-82495-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1495438565-82495-3-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_VULCAN (Broadcom Vulcan) has been discontinued and all its
dependencies have been moved to ARCH_THUNDER2. It can be dropped
from defconfig now.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 65cdd87..96224b2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -56,7 +56,6 @@ CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_THUNDER2=y
 CONFIG_ARCH_UNIPHIER=y
 CONFIG_ARCH_VEXPRESS=y
-CONFIG_ARCH_VULCAN=y
 CONFIG_ARCH_XGENE=y
 CONFIG_ARCH_ZX=y
 CONFIG_ARCH_ZYNQMP=y
-- 
2.7.4
