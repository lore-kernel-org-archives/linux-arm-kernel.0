From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  3 Apr 2014 12:30:14 -0300
Subject: [PATCH 2/2] ARM: mvebu: enable fhandle in the defconfigs
In-Reply-To: <1396539014-8673-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1396539014-8673-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1396539014-8673-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_FHANDLE is required by systemd >= 210 to spawn a serial TTY.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_v5_defconfig | 1 +
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 36484a3..5d8ec15 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -1,4 +1,5 @@
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=19
diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index bfcc362..b1e514e 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -1,5 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-- 
1.9.1
