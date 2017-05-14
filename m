From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 14 May 2017 15:13:49 +0000
Subject: [PATCH 1/2] ARM: mxs_defconfig: Enable CONFIG_CGROUPS
Message-ID: <1494774830-2823-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support systemd we need to enable CONFIG_CGROUPS.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/mxs_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 6e0f751..7b36ebb 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -8,6 +8,7 @@ CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_CGROUPS=y
 # CONFIG_UTS_NS is not set
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
-- 
1.7.9.5
