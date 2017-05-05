From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri,  5 May 2017 10:43:43 +0200
Subject: [PATCH 2/2] ARM: at91/defconfig: enable HIGH_RES_TIMERS
In-Reply-To: <20170505084343.10417-1-quentin.schulz@free-electrons.com>
References: <20170505084343.10417-1-quentin.schulz@free-electrons.com>
Message-ID: <20170505084343.10417-2-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables by default the high resolution timers on sama5d2 platforms.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 2e1f096c96cb..4c914da669ea 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYSVIPC=y
 CONFIG_FHANDLE=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
-- 
2.11.0
