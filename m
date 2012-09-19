From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Sep 2012 08:18:51 +0900
Subject: [GIT PULL 4/7] Samsung gscaler for v3.7
Message-ID: <099b01cd96bd$21457d80$63d07880$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Here is G-Scaler DT for supporting EXYNOS5 SoCs.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/dt-gscaler

Shaik Ameer Basha (2):
      ARM: EXYNOS: Add clock support for G-Scaler
      ARM: EXYNOS: Adds G-Scaler device from Device Tree

 .../devicetree/bindings/media/exynos5-gsc.txt      |   30 +++++++
 arch/arm/boot/dts/exynos5250.dtsi                  |   28 +++++++
 arch/arm/mach-exynos/clock-exynos5.c               |   86
++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/map.h            |    5 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    8 ++
 5 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/exynos5-gsc.txt
