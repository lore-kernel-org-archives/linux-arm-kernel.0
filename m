From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Apr 2011 06:22:31 +0900
Subject: [GIT PULL] Samsung fixes for 2.6.39-rc4
Message-ID: <008701cbfd45$94dd8f70$be98ae50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull Samsung fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

These things are small fixes for 2.6.39-rc4.
If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit a6360dd37e1a144ed11e6548371bade559a1e4df:

  Linux 2.6.39-rc3 (2011-04-11 17:21:51 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

Abhilash Kesavan (2):
      ARM: S5P: Remove unused s3c_pm_check_resume_pin
      ARM: SAMSUNG: Fix build failure in PM CRC check code

Maurus Cuelenaere (1):
      ARM: SAMSUNG: Fix warning 's3c_pm_show_resume_irqs' defined but not
used

 arch/arm/plat-s5p/pm.c           |   11 -----------
 arch/arm/plat-samsung/pm-check.c |    6 ------
 arch/arm/plat-samsung/pm.c       |    5 +++--
 3 files changed, 3 insertions(+), 19 deletions(-)
