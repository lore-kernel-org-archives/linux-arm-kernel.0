From: jonghwa3.lee@samsung.com (Jonghwa Lee)
Date: Fri, 26 Sep 2014 16:23:20 +0900
Subject: [PATCH 0/2] ARM: EXYNOS3250: Add support EXYNOS3250 suspend/resume.
Message-ID: <1411716202-31644-1-git-send-email-jonghwa3.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches adds and modifies exynos suspend driver to support exynos3250's
suspend/resume. To work suspend/resume, it also needs a work at pmu driver.
It'll be supported after refactoring job on pmu driver is done.

Jonghwa Lee (2):
  ARM: EXYNOS: suspend: Make restoring registers into selectable
    option.
  ARM: EXYNOS3250: Add initial support EXYNOS3250 suspend/resume.

 arch/arm/mach-exynos/regs-pmu.h |    4 +++
 arch/arm/mach-exynos/suspend.c  |   70 +++++++++++++++++++++++++++++----------
 2 files changed, 56 insertions(+), 18 deletions(-)

-- 
1.7.9.5
