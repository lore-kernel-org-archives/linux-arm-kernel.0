From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 27 Apr 2016 09:11:45 -0500
Subject: [PATCH 2/5] ARM: keystone: defconfig: Enable PINCTRL SINGLE for
 Keystone 2
In-Reply-To: <1461766308-27669-1-git-send-email-fcooper@ti.com>
References: <1461766308-27669-1-git-send-email-fcooper@ti.com>
Message-ID: <1461766308-27669-3-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer Keystone 2 devices utilize pinmuxing. Enable PINCTRL SINGLE
which is used to handle pinmuxing.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/configs/keystone_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 5bcc9cf..d068421 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -208,3 +208,4 @@ CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_USER_API_SKCIPHER=y
+CONFIG_PINCTRL_SINGLE=y
-- 
2.7.0
