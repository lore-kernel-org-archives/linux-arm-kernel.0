From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 08 Jul 2010 20:19:36 +0900
Subject: [GIT PULL] Samsung fixes for 2.6.35-rc5
Message-ID: <020501cb1e8f$756067c0$60213740$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

Please pull Samsung fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

These things are for bug fix on 2.6.35-rc.
If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


The following changes since commit 815c4163b6c8ebf8152f42b0a5fd015cfdcedc78

  Linux 2.6.35-rc4

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

Boojin Kim (1):
      ARM: S5P: Bug fix on external interrupt for S5P SoCs

Hyuk Lee (1):
      ARM: SAMSUNG: Fix on wrong function name for S5PV210 sdhci0

Marek Szyprowski (1):
      ARM: SAMSUNG: Fix build without SDHCI controllers for S3C64XX

MyungJoo Ham (1):
      ARM: S5PV210: Correct clock register properties

Thomas Abraham (1):
      ARM: S5P6442: Fix PLL setting announce message.

 arch/arm/mach-s5p6442/clock.c              |    2 +-
 arch/arm/mach-s5pv210/clock.c              |  115
+++++++++++++++-------------
 arch/arm/plat-s5p/irq-eint.c               |    2 +-
 arch/arm/plat-samsung/include/plat/sdhci.h |    4 +-
 4 files changed, 67 insertions(+), 56 deletions(-)
