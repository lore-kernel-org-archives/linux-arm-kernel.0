From: prasanna.ps@samsung.com (Prasanna Kumar)
Date: Tue, 27 Nov 2012 17:52:34 +0530
Subject: [PATCH 0/3]ARM: Exynos5 : Add Power domain device tree support and fix
 for hardware issue
Message-ID: <1354018957-17752-1-git-send-email-prasanna.ps@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prasanna Kumar <prasanna.ps@samsung.com>

Hello all,

This patch set is for "for-next" branch.

In this patch set, the first patch adds device tree support for
G-Scaler and MFC power domains of Exynos5. 

The second patch enables power domain support for exynos5 in Kconfig

The last patch provides a software fix for hardware issue found in exynos5
while powergating the power domains.

Prasanna Kumar (3):
  ARM: dts: exynos5: Set up power domain for MFC and G-scaler
  arm: exynos5: Enable PM generic domain support in Kconfig
  ARM: EXYNOS5: save CLK_TOP_SRC3 register before powergating

 arch/arm/boot/dts/exynos5250.dtsi |   15 +++++++++++++++
 arch/arm/mach-exynos/Kconfig      |    1 +
 arch/arm/mach-exynos/pm_domains.c |   27 +++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 0 deletions(-)
