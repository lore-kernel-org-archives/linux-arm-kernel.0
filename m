From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 13 May 2012 08:37:28 +0900
Subject: [GIT PULL] Samsung fixes for v3.4
In-Reply-To: <CAOesGMj8PgGRmdQQSnJmAurL1uYM2exxDaeTTWHVe9JQR0zQ-w@mail.gmail.com>
References: <4FAED92C.4090103@samsung.com>
 <CAOesGMj8PgGRmdQQSnJmAurL1uYM2exxDaeTTWHVe9JQR0zQ-w@mail.gmail.com>
Message-ID: <4FAEF438.6010802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull Samsung fixes for v3.4:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.4-samsung-fixes-5

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

   Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.4-samsung-fixes-5

Kukjin Kim (1):
       ARM: EXYNOS: fix ctrlbit for exynos5_clk_pdma1

Marek Szyprowski (1):
       ARM: EXYNOS: use s5p-timer for UniversalC210 board

  arch/arm/mach-exynos/Kconfig               |    3 +++
  arch/arm/mach-exynos/clock-exynos5.c       |    2 +-
  arch/arm/mach-exynos/mach-universal_c210.c |    4 +++-
  3 files changed, 7 insertions(+), 2 deletions(-)
