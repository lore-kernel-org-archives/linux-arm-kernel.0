From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 22 Mar 2017 17:03:30 +0900
Subject: [PATCH 0/2] pinctrl: samsung: Fix PINCFG_TYPE_DRV bitfields for
 Exynos5433
References: <CGME20170322080334epcas1p2531fbfdd3c3e033b0f67c5a5cf63b6a1@epcas1p2.samsung.com>
Message-ID: <1490169812-25225-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches add the missing part about PINCFG_TYPE_DRV bitfields
for Exynos5433 when merged the multiple patches for pinctrl-exynos.c
and this patch removes the unused EXYNOS_PIN_BANK_EINTW_EXT macro.

Also, patch1 and patch2 will be possible squashed if the separate patch
is not necesasry.

Chanwoo Choi (2):
  pinctrl: samsung: Add missing part for PINCFG_TYPE_DRV of Exynos5433
  pinctrl: samsung: Remove unused pin-bank macro

 drivers/pinctrl/samsung/pinctrl-exynos.c | 80 ++++++++++++++++----------------
 drivers/pinctrl/samsung/pinctrl-exynos.h | 11 -----
 2 files changed, 40 insertions(+), 51 deletions(-)

-- 
1.9.1
