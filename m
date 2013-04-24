From: vkale@apm.com (Vinayak Kale)
Date: Wed, 24 Apr 2013 14:36:58 +0530
Subject: [PATCH V3 2/4] arm64: Enable APM X-Gene SOC family in the defconfig
In-Reply-To: <1366794420-17849-1-git-send-email-vkale@apm.com>
References: <1366794420-17849-1-git-send-email-vkale@apm.com>
Message-ID: <1366794420-17849-3-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables APM X-Gene SOC family in the defconfig. It also enables 8250 serial driver needed by X-Gene SOC family.

Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/configs/defconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 09bef29..7dfad0a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -23,6 +23,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_XGENE=y
 CONFIG_SMP=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_CMDLINE="console=ttyAMA0"
@@ -52,6 +53,9 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_LEGACY_PTY_COUNT=16
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_FB=y
-- 
1.7.4.1
