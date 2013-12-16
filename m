From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 16 Dec 2013 18:39:38 +0200
Subject: [PATCH 2/4] ARM: keystone_defconfig: enable gpio support
In-Reply-To: <1387211981-26045-1-git-send-email-grygorii.strashko@ti.com>
References: <1387211981-26045-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1387211981-26045-3-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable enable GPIO support for Keystone by setting CONFIG_GPIOLIB and
CONFIG_GPIO_DAVINCI options in keystone_defconfig.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/configs/keystone_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 9943e5d..e911f7f 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -158,3 +158,6 @@ CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_USER_API_SKCIPHER=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_DAVINCI=y
-- 
1.7.9.5
