From: carlo@caione.org (Carlo Caione)
Date: Sun,  4 May 2014 16:02:40 +0200
Subject: [PATCH 2/2] ARM: sunxi: Add syscon support in defconfig
In-Reply-To: <1399212160-26934-1-git-send-email-carlo@caione.org>
References: <1399212160-26934-1-git-send-email-carlo@caione.org>
Message-ID: <1399212160-26934-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/sunxi_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47..d04fef5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -343,3 +343,4 @@ CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_CRYPTO_DEV_TEGRA_AES=y
+CONFIG_MFD_SYSCON=y
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index b5df4a5..2ee8838 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -69,3 +69,4 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS=y
 CONFIG_PRINTK_TIME=y
+CONFIG_MFD_SYSCON=y
-- 
1.8.3.2
