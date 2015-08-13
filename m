From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 13 Aug 2015 09:13:12 +0900
Subject: [GIT PULL 2nd 4/4] Samsung defconfig 2nd update for v4.3
Message-ID: <55CBE118.7060000@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is enable cpufreq-dt driver for exynos stuff.

Please pull and sorry for little bit confused branches in this time...

Thanks,
Kukjin


The following changes since commit c3e71f4b5f580b43e0eb3be18059c8844d8713e7:

  ARM: multi_v7_defconfig: Enable max77802 regulator (2015-08-12
08:15:02 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-defconfig-2

for you to fetch changes up to 2b347c6494cbc6bfdc81b5201b8aa34afb2c3500:

  ARM: exynos_defconfig: Enable cpufreq-dt driver (2015-08-12 08:17:31
+0900)

----------------------------------------------------------------
Samsung 2nd defconfig updates for v4.3

- enable cpufreq-dt driver with ONDEMAND governor
  for Exynos SoCs 3250, 4210, 4212, 4412 and 5250

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Enable cpufreq-dt driver

 arch/arm/configs/exynos_defconfig | 2 ++
 1 file changed, 2 insertions(+)
