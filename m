From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 Dec 2011 10:50:28 +0900
Subject: [GIT PULL] Samsung Fixes for v3.2
Message-ID: <02c701ccc695$685501d0$38ff0570$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This is Samsung fixes for v3.2

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.2-samsung-fixes-4

The 'ARM: SAMSUNG: Fix build error...' is fixing of build in some case of
only selection s3c2440 in kernel configuration and the 'ARM: EXYNOS: Remove
duplicated...' can cause the detection of overlapped memory region which
resulted in boot failure.

If any problem, please kindly let me know.

Arnd, since v3.2 is now close at hand, I'm sending this to Linus.

Linus, Arnd and all Linux guys,
Happy New Year :)
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 5f0a6e2d503896062f641639dacfe5055c2f593b:

  Linux 3.2-rc7 (2011-12-23 21:51:06 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.2-samsung-fixes-4

Denis Kuzmenko (1):
      ARM: SAMSUNG: Fix build error when selecting CPU_FREQ_S3C24XX_DEBUGFS
on S3C2440

Thomas Abraham (1):
      ARM: EXYNOS: Remove duplicated SROMC static memory mapping

 arch/arm/mach-exynos/cpu.c                         |    5 ----
 arch/arm/plat-samsung/include/plat/cpu-freq-core.h |   25
++++++++++++--------
 2 files changed, 15 insertions(+), 15 deletions(-)
