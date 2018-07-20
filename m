From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 20 Jul 2018 16:30:10 +0200
Subject: [PATCH 4/6] ARM: defconfig: tegra: enable dynamic debug
In-Reply-To: <20180720143012.7740-1-marcel@ziswiler.com>
References: <20180720143012.7740-1-marcel@ziswiler.com>
Message-ID: <20180720143012.7740-4-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Dynamic debug is really helpful.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index c7b99ebf5fcf..24e297659b55 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -289,6 +289,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SLAB=y
-- 
2.14.4
