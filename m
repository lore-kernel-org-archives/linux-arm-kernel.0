From: jnair@caviumnetworks.com (Jayachandran C)
Date: Sun, 5 Feb 2017 00:57:06 +0000
Subject: [PATCH v2 5/5] arm64: add ARCH_THUNDER2 to defconfig
In-Reply-To: <1486256226-43889-1-git-send-email-jnair@caviumnetworks.com>
References: <1486256226-43889-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1486256226-43889-6-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow the default kernel build to boot on Cavium ThunderX2
CN99XX processors.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 33b744d..7a9c262 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -53,6 +53,7 @@ CONFIG_ARCH_STRATIX10=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_SPRD=y
 CONFIG_ARCH_THUNDER=y
+CONFIG_ARCH_THUNDER2=y
 CONFIG_ARCH_UNIPHIER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_VULCAN=y
-- 
2.7.4
