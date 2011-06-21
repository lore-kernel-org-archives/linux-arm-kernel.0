From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 21 Jun 2011 10:58:46 +0900
Subject: [PATCH v2 4/5] ARM: S5PC110/S5PV210: Support ADC
In-Reply-To: <1308621527-2457-1-git-send-email-myungjoo.ham@samsung.com>
References: <20110620101737.GA31864@opensource.wolfsonmicro.com>
	<1308621527-2457-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1308621527-2457-5-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
v2: No changes from v1. Resubmitted as a series of patches
---
 arch/arm/mach-s5pv210/cpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 61e6c24..8b68e30 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -126,7 +126,7 @@ void __init s5pv210_map_io(void)
 	s5pv210_default_sdhci2();
 	s5pv210_default_sdhci3();
 
-	s3c_adc_setname("s3c64xx-adc");
+	s3c_adc_setname("s5p-adc");
 
 	s3c_cfcon_setname("s5pv210-pata");
 
-- 
1.7.4.1
