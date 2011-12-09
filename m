From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Fri,  9 Dec 2011 17:06:49 +0200
Subject: [PATCH 1/3] arm: tools: mach-types: add nokia_rm696
In-Reply-To: <1323443211-3648-1-git-send-email-aaro.koskinen@nokia.com>
References: <1323443211-3648-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <1323443211-3648-2-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the mach-type number for RM-696.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/tools/mach-types |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index ccbe16f..63f20da 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -1123,6 +1123,7 @@ blissc			MACH_BLISSC		BLISSC			3491
 thales_adc		MACH_THALES_ADC		THALES_ADC		3492
 ubisys_p9d_evp		MACH_UBISYS_P9D_EVP	UBISYS_P9D_EVP		3493
 atdgp318		MACH_ATDGP318		ATDGP318		3494
+nokia_rm696		MACH_NOKIA_RM696	NOKIA_RM696		3522
 m28evk			MACH_M28EVK		M28EVK			3613
 smdk4212		MACH_SMDK4212		SMDK4212		3638
 smdk4412		MACH_SMDK4412		SMDK4412		3765
-- 
1.7.2.5
