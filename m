From: carlo@caione.org (Carlo Caione)
Date: Tue, 16 Sep 2014 22:43:37 +0200
Subject: [PATCH 4/4] ARM: defconfig: update multi_v7_defconfig
In-Reply-To: <1410900217-5162-1-git-send-email-carlo@caione.org>
References: <1410900217-5162-1-git-send-email-carlo@caione.org>
Message-ID: <1410900217-5162-5-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the multi_v7_defconfig enabling the watchdog driver for Meson
SoCs.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5b44796..560e6a9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -242,6 +242,7 @@ CONFIG_ST_THERMAL_MEMMAP=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
+CONFIG_MESON_WATCHDOG=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_BCM590XX=y
 CONFIG_MFD_CROS_EC=y
-- 
1.9.1
