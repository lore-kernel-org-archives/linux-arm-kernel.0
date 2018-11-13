From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Tue, 13 Nov 2018 10:06:13 -0600
Subject: [RESEND 3/4] arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
In-Reply-To: <1542125174-8204-1-git-send-email-thor.thayer@linux.intel.com>
References: <1542125174-8204-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1542125174-8204-4-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Enable the Stratix10 System Manager by default.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a57d11330b..873d807bb82b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -392,6 +392,7 @@ CONFIG_MESON_WATCHDOG=m
 CONFIG_RENESAS_WDT=y
 CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=y
-- 
2.7.4
