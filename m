From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 26 Mar 2014 11:29:32 +0900
Subject: [PATCH 2/2] ARM: enable fhandle in multi_v7_defconfig
In-Reply-To: <1395800972-26483-1-git-send-email-acourbot@nvidia.com>
References: <1395800972-26483-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1395800972-26483-2-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_FHANDLE is required by systemd >= 210 to spawn a serial TTY.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index dc02635ca473..cee30d8d253c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1,4 +1,5 @@
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
-- 
1.9.1
