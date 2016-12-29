From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 29 Dec 2016 17:42:07 +0900
Subject: [PATCH 0/4] Use Exynos macros for pinctrl settings
References: <CGME20161229084221epcas1p4d76b4b30f59734f7eee29aec53b54af3@epcas1p4.samsung.com>
Message-ID: <20161229084211.20442-1-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset is just a refactoring of the exynos5433 and TM2
pinctrl definitions. Standing to the samsung-pinctrl.txt binding
the Exynos related DTS should use the macros introduced by
commit:

5db7e3bb87df ("pinctrl: dt-bindings: samsung: Add header with
       values used for configuration")

Would be nice to see in the future all the PIN related macros in
the same file, as they more or less do the same thing.

Thanks,
Andi


Andi Shyti (4):
  pinctrl: dt-bindings: samsung: add drive strength macros for
    Exynos5433
  ARM64: dts: exynos5433: use macros for pinctrl configuration on
    Exynos5433
  ARM64: dts: TM2: comply to the samsung pinctrl naming convention
  ARM64: dts: exynos5433: remove unused code

 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi | 373 ++++++++++-----------
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 254 +++++++-------
 include/dt-bindings/pinctrl/samsung.h              |   6 +
 3 files changed, 314 insertions(+), 319 deletions(-)

-- 
2.11.0
