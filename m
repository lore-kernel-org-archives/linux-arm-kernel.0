From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 22 Jun 2011 17:46:38 +0900
Subject: [PATCH 0/7] ARM: EXYNOS4: Update PM
Message-ID: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note: This depends on external GIC of EXYNOS4.

[PATCH 1/7] ARM: EXYNOS4: Support system level power down configuration
[PATCH 2/7] ARM: EXYNOS4: Remove PMU configuration for S2RAM
[PATCH 3/7] ARM: EXYNOS4: Add support PM with external GIC
[PATCH 4/7] ARM: EXYNOS4: Support early wakeup while entering sleep mode
[PATCH 5/7] ARM: EXYNOS4: Add save/restore function for PLL
[PATCH 6/7] ARM: EXYNOS4: Add save/restore for more ARM registers
[PATCH 7/7] ARM: EXYNOS4: Move S5P_CENTRAL_SEQ_CONFIGURATION setting for PM
