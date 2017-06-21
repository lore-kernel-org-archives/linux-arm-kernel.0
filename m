From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 21 Jun 2017 12:30:45 -0500
Subject: [PATCH 6/8] arm64: defconfig: enable EDAC options
In-Reply-To: <1498066247-22130-1-git-send-email-timur@codeaurora.org>
References: <1498066247-22130-1-git-send-email-timur@codeaurora.org>
Message-ID: <1498066247-22130-7-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable EDAC (Error Detection and Correction) support for ARM64 server
systems that feature it, so that user space applications can be
notified of memory errors.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0d86a8a..6a52906 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -427,6 +427,7 @@ CONFIG_LEDS_SYSCON=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
