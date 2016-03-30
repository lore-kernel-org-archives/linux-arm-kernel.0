From: bp@alien8.de (Borislav Petkov)
Date: Wed, 30 Mar 2016 13:42:44 +0200
Subject: [PATCH 1/5] arm/defconfigs: Remove CONFIG_IPV6_PRIVACY
In-Reply-To: <1459338168-29334-1-git-send-email-bp@alien8.de>
References: <1459338168-29334-1-git-send-email-bp@alien8.de>
Message-ID: <1459338168-29334-2-git-send-email-bp@alien8.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Borislav Petkov <bp@suse.de>

Option is long gone, see

  5d9efa7ee99e ("ipv6: Remove privacy config option.")

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/configs/lpc32xx_defconfig | 1 -
 arch/arm/configs/s3c2410_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 9f56ca3985ae..d1da7de9613c 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -45,7 +45,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_IPV6=y
-CONFIG_IPV6_PRIVACY=y
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index b3ade552a2a5..bc4bfe02e611 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -76,7 +76,6 @@ CONFIG_TCP_CONG_LP=m
 CONFIG_TCP_CONG_VENO=m
 CONFIG_TCP_CONG_YEAH=m
 CONFIG_TCP_CONG_ILLINOIS=m
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
-- 
2.7.3
