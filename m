From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 18 Sep 2016 18:39:46 +0200
Subject: [GIT PULL 1/3] ARM: soc: exynos: Drivers for v4.9
In-Reply-To: <1474216788-17282-1-git-send-email-krzk@kernel.org>
References: <1474216788-17282-1-git-send-email-krzk@kernel.org>
Message-ID: <1474216788-17282-2-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Hi,

Drivers related changes.


Best regards,
Krzysztof


The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.9-2

for you to fetch changes up to 8bc6bf178b671eb9b9fa806804f3990cb4c332aa:

  dt-bindings: EXYNOS: Add Exynos5433 PMU compatible (2016-09-16 13:21:04 +0200)

----------------------------------------------------------------
Samsung drivers/soc update for v4.9:
1. Allow compile testing of exynos-mct clocksource driver on ARM64.
2. Document Exynos5433 PMU compatible (already used by clkout driver and more
   will be coming soon).

----------------------------------------------------------------
Chanwoo Choi (2):
      clocksource: exynos_mct: Add the support for ARM64
      dt-bindings: EXYNOS: Add Exynos5433 PMU compatible

 Documentation/devicetree/bindings/arm/samsung/pmu.txt | 1 +
 drivers/clocksource/Kconfig                           | 2 +-
 drivers/clocksource/exynos_mct.c                      | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)
