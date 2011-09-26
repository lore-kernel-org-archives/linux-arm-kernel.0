From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 Sep 2011 08:22:00 +0900
Subject: [GIT PULL] Samsung Fixes for v3.1
Message-ID: <003101cc7ca3$1820d4a0$48627de0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This is Samsung fixes for v3.1

Please pull from:
  git://github.com/kgene/linux-samsung.git samsung-fixes-3

These things are needed for v3.1 and if any problems, please let me know.

Arnd, since v3.1 is now close at hand, I'm sending this to Linus...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit d93dc5c4478c1fd5de85a3e8aece9aad7bbae044:

  Linux 3.1-rc7 (2011-09-21 16:58:15 -0700)

are available in the git repository at:
 git://github.com/kgene/linux-samsung.git samsung-fixes-3

Heiko Stuebner (1):
      ARM: S3C2443: Fix bit-reset in setrate of clk_armdiv

Marek Szyprowski (1):
      ARM: S5P: fix incorrect loop iterator usage on gpio-interrupt

Sylwester Nawrocki (2):
      ARM: S5PV210: Rename sclk_cam clocks for FIMC media driver
      ARM: EXYNOS4: Rename sclk_cam clocks for FIMC driver

 arch/arm/mach-exynos4/clock.c   |    6 ++----
 arch/arm/mach-s3c2443/clock.c   |    2 +-
 arch/arm/mach-s5pv210/clock.c   |    6 ++----
 arch/arm/plat-s5p/irq-gpioint.c |    9 +++++----
 4 files changed, 10 insertions(+), 13 deletions(-)
