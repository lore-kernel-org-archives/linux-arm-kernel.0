From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 16:49:34 +0900
Subject: [PATCH v3 5/6] ARM: S5PC110/S5PV210: Support ADC
In-Reply-To: <1309420175-10301-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309420175-10301-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309420175-10301-6-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/cpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 61e6c24..79907ec 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -126,7 +126,7 @@ void __init s5pv210_map_io(void)
 	s5pv210_default_sdhci2();
 	s5pv210_default_sdhci3();
 
-	s3c_adc_setname("s3c64xx-adc");
+	s3c_adc_setname("samsung-adc-v3");
 
 	s3c_cfcon_setname("s5pv210-pata");
 
-- 
1.7.4.1
