From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 Mar 2011 13:51:11 +0900
Subject: [PATCH V2 0/3] ARM: EXYNOS4: Suspend to RAM Support
Message-ID: <1299732674-6752-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support suspend to ram on EXYNOS4.
This is made based on generic CPU sleep support.

Changes since v1:
- re-maded based on rmk/pm
- added some more registers of CMU to save and restore
- fixed MAUDIO retention after resuming

[PATCH V2 1/3] ARM: EXYNOS4: Add PMU and CMU Registers for PM
[PATCH V2 2/3] ARM: EXYNOS4: Suspend to RAM Support
[PATCH V2 3/3] ARM: EXYNOS4: Update HRT for supporting PM
