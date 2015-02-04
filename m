From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 04 Feb 2015 23:31:23 +0900
Subject: [GIT PULL 1/3] Samsung exynos_defconfig updates for v3.20
Message-ID: <54D22D3B.4010704@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

Here is late pull request for exynos_defconfig updates for v3.20 and if
you're OK please pull.

Note this is based on previous exynos_defconfig pull-request during
v3.19-rc.

Thanks,
Kukjin


The following changes since commit 842ebf60bbad6d6e5ebaa063409fefdd2a7eb992:

  ARM: exynos_defconfig: Enable LM90 driver (2014-12-23 00:20:44 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-defconfig

for you to fetch changes up to 39ecb024e9727c9c29765ca233bdca91c8589d01:

  ARM: exynos_defconfig: Enable CONFIG_FHANDLE (2015-01-24 13:50:01 +0900)

----------------------------------------------------------------
Samsung exynos_defconfig updates for v3.20

- Enable CONFIG_LOCKUP_DETECTOR
  : to detect hard lockup and soft lockup
- Enable PMIC and MUIC
  : for battery charger, fuel-gauge, regulators
- Enable CONFIG_FHANDLE
  : this is required by systemd

----------------------------------------------------------------
Anand Moon (1):
      ARM: exynos_defconfig: Enable CONFIG_LOCKUP_DETECTOR

Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Enable PMIC and MUIC drivers for Gears and
Trats2

Sjoerd Simons (1):
      ARM: exynos_defconfig: Enable CONFIG_FHANDLE

 arch/arm/configs/exynos_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)
