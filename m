From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Mar 2012 07:26:25 -0700
Subject: [PATCH 0/5] ARM: EXYNOS: add support PM for EXYNOS5250
Message-ID: <1331735190-28773-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support power management for EXYNOS5250 SoCs
and incudes regarding cleanup.

NOTE: this can be applied on top of next/soc-exynos5250-arch
of linux-samsung.git cleanly.

[PATCH 1/5] ARM: EXYNOS: Remove GIC save & restore function
[PATCH 2/5] ARM: EXYNOS: Rename of function for pm.c
[PATCH 3/5] ARM: EXYNOS: Add PMU table for EXYNOS5250
[PATCH 4/5] ARM: EXYNOS: Add Clock register list for save and
[PATCH 5/5] ARM: EXYNOS: Support suspend and resume for EXYNOS5250
