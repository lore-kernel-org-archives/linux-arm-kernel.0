From: chaos.youn@samsung.com (Changhwan Youn)
Date: Mon, 20 Jun 2011 16:34:11 +0900
Subject: [PATCH 0/7] ARM: EXYNOS4: Adds External GIC
Message-ID: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds implementation External GIC on EXYNOS4 SoC.

Note: need to update timer codes for supporting old type of
EXYNOS4 SoCs.

[PATCH 1/7] ARM: EXYNOS4: Add external GIC io memory mapping
[PATCH 2/7] ARM: EXYNOS4: modify interrupt mappings for external GIC
[PATCH 3/7] ARM: EXYNOS4: set the affinity of mct1 interrupt using IRQ_MCT_L1
[PATCH 4/7] ARM: GIC: move gic_chip_data structure declaration to header
[PATCH 5/7] ARM: EXYNOS4: Add support external GIC
[PATCH 6/7] ARM: EXYNOS4: Remove clock event timers using ARM private timers
[PATCH 7/7] ARM: EXYNOS4: Add chained enrty/exit function to uart interrupt handler
