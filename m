From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 17 Jul 2012 06:52:04 +0900
Subject: [GIT PULL] Samsung board-2 for v3.6
Message-ID: <142d01cd639d$3ce29530$b6a7bf90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull second Samsung board updating for v3.6 from:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/board-samsung-2

The branch includes updating each Samsung boards such as SMDK4X12, Aquila,
Goni and so on, and it is for audio platform device and supporting of HSOTG
or framebuffer.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit d6e2796b3b8d94b7048dc63162b93936c25485cd:

  Merge branch 'next/board-samsung' into next/board-samsung-2 (2012-07-13
18:40:17 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/board-samsung-2

Mark Brown (1):
      ARM: S3C64XX: Don't specify an irq_base for WM1192-EV1 board

Sachin Kamat (5):
      ARM: EXYNOS: Add audio platform device in SMDKV310 board
      ARM: S5PV210: Add audio platform device in Aquila board
      ARM: S5PV210: Add audio platform device in Goni board
      ARM: EXYNOS: Add HSOTG support to SMDK4X12
      ARM: EXYNOS: Add framebuffer support for SMDK4X12

 arch/arm/mach-exynos/Kconfig          |    4 +++
 arch/arm/mach-exynos/mach-smdk4x12.c  |   41
+++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/mach-smdkv310.c  |    7 +++++
 arch/arm/mach-s3c64xx/mach-smdk6410.c |    1 -
 arch/arm/mach-s5pv210/mach-aquila.c   |    7 +++++
 arch/arm/mach-s5pv210/mach-goni.c     |    7 +++++
 6 files changed, 66 insertions(+), 1 deletions(-)
