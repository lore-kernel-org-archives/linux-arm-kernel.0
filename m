From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Sep 2012 11:38:03 +0200
Subject: [PATCH 0/3] ARM: EXYNOS: Power domain DT support extension
Message-ID: <1346924286-9584-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes two issues with existing DT support for Exynos
power domains and extends it with the ability of binding devices to domains,
basically making it possible to use power domains when using DT.

Tomasz Figa (3):
  ARM: EXYNOS: pm_domain: Detect domain state on registration from DT
  ARM: EXYNOS: pm_domain: Fix power domain name initialization
  ARM: EXYNOS: pm_domain: Bind devices to power domains using DT

 .../bindings/arm/exynos/power_domain.txt           | 15 +++-
 arch/arm/mach-exynos/pm_domains.c                  | 93 +++++++++++++++++++++-
 2 files changed, 100 insertions(+), 8 deletions(-)

-- 
1.7.12
