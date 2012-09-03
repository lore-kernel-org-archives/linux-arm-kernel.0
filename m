From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 03 Sep 2012 14:34:31 +0200
Subject: [PATCH 0/3] ARM: dts: Exynos4 dts reorganization
Message-ID: <1346675674-16034-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series prepares existing Exynos4210 DT infrastructure to be
further extended for new SoCs from Exynos4 line and new boards.

Tomasz Figa (3):
  ARM: dts: Move parts common to Exynos4 from Exynos4210.dtsi to
    Exynos4.dtsi
  ARM: EXYNOS: exynos4-dt: Use exynos4 prefix instead of exynos4210
  ARM: dts: exynos4: Assume status of all optional nodes as disabled

 arch/arm/boot/dts/exynos4.dtsi            | 232 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210-origen.dts   |  58 +-------
 arch/arm/boot/dts/exynos4210-smdkv310.dts |  52 +------
 arch/arm/boot/dts/exynos4210.dtsi         | 181 +----------------------
 arch/arm/mach-exynos/mach-exynos4-dt.c    |  18 +--
 5 files changed, 248 insertions(+), 293 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4.dtsi

-- 
1.7.12
