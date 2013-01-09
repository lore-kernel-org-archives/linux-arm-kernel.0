From: prasanna.ps@samsung.com (Prasanna Kumar)
Date: Wed, 09 Jan 2013 17:45:31 +0530
Subject: [PATCH 0/2] ARM: Exynos5 : Add Power domain device tree support for
 MFC and GSC
Message-ID: <1357733733-18769-1-git-send-email-prasanna.ps@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

This patch set adds device tree support for power domains (Gscaler and
MFC) of exynos5

Prasanna Kumar (2):
  arm: exynos5: Enable PM generic domain support in Kconfig
  ARM: dts: exynos5: Set up power domain for  MFC and G-scaler

 arch/arm/boot/dts/exynos5250.dtsi |   15 +++++++++++++++
 arch/arm/mach-exynos/Kconfig      |    1 +
 2 files changed, 16 insertions(+), 0 deletions(-)

-- 
1.7.5.4
