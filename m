From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Wed,  8 Feb 2017 23:08:45 +0100 (CET)
Subject: [PATCH 3/4] ARM: multi_v7_defconfig: Enable AC100 RTC driver
In-Reply-To: <937914a68e4e7d6db2d12540cc6253b200978e2d.1486590875.git.rask@formelder.dk>
References: <937914a68e4e7d6db2d12540cc6253b200978e2d.1486590875.git.rask@formelder.dk>
Message-ID: <67ca5dceabc614510f4ce22d781fb0f69445ce6a.1486590875.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the AC100 RTC driver so boards with it can keep track of time.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
---
This patch will have no effect if patch 2/4 is not applied.

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ec3a110..5868186 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -480,6 +480,7 @@ CONFIG_MFD_AS3722=y
 CONFIG_MFD_ATMEL_FLEXCOM=y
 CONFIG_MFD_ATMEL_HLCDC=m
 CONFIG_MFD_BCM590XX=y
+CONFIG_MFD_AC100=y
 CONFIG_MFD_AXP20X=y
 CONFIG_MFD_AXP20X_I2C=m
 CONFIG_MFD_AXP20X_RSB=m
@@ -749,6 +750,7 @@ CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_HIGHBANK_MC=y
 CONFIG_EDAC_HIGHBANK_L2=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_AC100=y
 CONFIG_RTC_DRV_AS3722=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_HYM8563=m
-- 
2.10.2
