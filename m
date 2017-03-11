From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 23:38:53 +0200
Subject: [PATCH 0/3] arm64: exynos: Enable drivers for Exynos5433
Message-ID: <20170311213856.21701-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Patches are independent but I organized them into one patchset
as they have common goal - enable more drivers for ARMv8 Exynos chips.

If there are no objections, I can take it through samsung-soc.


Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  arm64: defconfig: Enable DRM and LPASS drivers for Exynos5433 and
    Exynos7
  soc: samsung: Do not build ARMv7 PMU drivers on ARMv8
  arm64: exynos: Enable Exynos PMU and PM domains drivers

 arch/arm64/Kconfig.platforms     |  2 ++
 arch/arm64/configs/defconfig     | 18 ++++++++++++++++++
 drivers/soc/samsung/Kconfig      |  8 +++++++-
 drivers/soc/samsung/Makefile     |  4 +++-
 drivers/soc/samsung/exynos-pmu.c | 22 ++++++++++++++++------
 drivers/soc/samsung/exynos-pmu.h |  3 +++
 6 files changed, 49 insertions(+), 8 deletions(-)

-- 
2.9.3
