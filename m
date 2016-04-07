From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Apr 2016 15:36:02 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: enable CONFIG_FHANDLE
Message-ID: <1460023562-7907-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_FHANDLE is required by systemd, which is the
default init system in more and more distributions.

So lets enable it for DaVinci platforms as well.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 235842c9ba96..d1b3799c08cc 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -2,6 +2,7 @@ CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-- 
2.6.3
