From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 16 Oct 2015 15:04:50 +0200
Subject: [PATCH v2 7/8] ARM: multi_v7_defconfig: Add Atmel Flexcom device
In-Reply-To: <1445000691-12402-1-git-send-email-ludovic.desroches@atmel.com>
References: <1445000691-12402-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1445000691-12402-8-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Flexcom device has been introduced with Atmel SAMA5D2 SoC.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 63703fa..6dcc048 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -389,6 +389,7 @@ CONFIG_MESON_WATCHDOG=y
 CONFIG_DIGICOLOR_WATCHDOG=y
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_AS3722=y
+CONFIG_MFD_ATMEL_FLEXCOM=y
 CONFIG_MFD_BCM590XX=y
 CONFIG_MFD_AXP20X=y
 CONFIG_MFD_CROS_EC=y
-- 
2.5.0
