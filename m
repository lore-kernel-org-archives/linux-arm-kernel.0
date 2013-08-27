From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Aug 2013 08:34:58 +0900
Subject: [GIT PULL V2 3/3] 2nd Round Samsung mach-exynos-v2 for v3.12
In-Reply-To: <87bo4j6aii.fsf@linaro.org>
References: <1f7701cea1f1$431f2d30$c95d8790$%kim@samsung.com>
 <3145165.ZB7l3vNJ7a@amdc1032>
 <CADGdYn7_Gm7rwkhRSUmvktB_hHNboY8eB5fi8E62-Br5Vk5D0A@mail.gmail.com>
 <4070794.XxjluIqBpK@amdc1032>
 <CADGdYn7YWscQ_EOqjbq29pNHvoxa0qqXHZeOBuz-Wi22H=Dc_w@mail.gmail.com>
 <87bo4j6aii.fsf@linaro.org>
Message-ID: <232401cea37e$0afca7a0$20f5f6e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-mach-exynos-v2

for you to fetch changes up to 1e9fec0e40deff9d18e4197b5f5f99f85f5d36a5:

   ARM: EXYNOS: Skip C1 cpuidle state for exynos5440 (2013-08-28 
00:51:21 +0900)

----------------------------------------------------------------
update mach-exynos v2 for v3.12
- enable ARCH_HAS_BANDGAP for exynos SoCs
- always enable PM domains for exynos4x12
- skip C1 cpuidle state for exynos5440

----------------------------------------------------------------
Amit Daniel Kachhap (2):
       ARM: EXYNOS: enable ARCH_HAS_BANDGAP
       ARM: EXYNOS: Skip C1 cpuidle state for exynos5440

Bartlomiej Zolnierkiewicz (1):
       ARM: EXYNOS: always enable PM domains support for EXYNOS4X12

  arch/arm/mach-exynos/Kconfig   | 7 +++++++
  arch/arm/mach-exynos/cpuidle.c | 3 +++
  2 files changed, 10 insertions(+)
