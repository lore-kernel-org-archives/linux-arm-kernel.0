From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 20 Jul 2018 16:30:09 +0200
Subject: [PATCH 3/6] ARM: multi_v7_defconfig: enable dynamic debug
In-Reply-To: <20180720143012.7740-1-marcel@ziswiler.com>
References: <20180720143012.7740-1-marcel@ziswiler.com>
Message-ID: <20180720143012.7740-3-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Dynamic debug is really helpful.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4a47a9de6a5e..beacb02c734b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -974,6 +974,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_USER_API_HASH=m
-- 
2.14.4
