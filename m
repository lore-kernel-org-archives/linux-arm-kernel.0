From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 07 Mar 2013 11:23:58 +0900
Subject: [GIT PULL 5/5] Samsung pinctrl-exynos5250 for v3.10
Message-ID: <016a01ce1ada$d34dd850$79e988f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is support pinctrl-exynos5250 and that already got ack from Linus Walliej.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/pinctrl-exynos

for you to fetch changes up to 97916777d6904e24b86eac77da58ef7cb09d539d:

  ARM: EXYNOS: skip wakeup interrupt registration for exynos5250 if pinctrl is
enabled (2013-03-05 20:59:12 +0900)

----------------------------------------------------------------
Thomas Abraham (3):
      pinctrl: exynos: add exynos5250 SoC specific data
      gpio: samsung: skip gpiolib registration if pinctrl support is enabled for
exynos5250
      ARM: EXYNOS: skip wakeup interrupt registration for exynos5250 if pinctrl
is enabled

 arch/arm/mach-exynos/common.c     |    1 +
 drivers/gpio/gpio-samsung.c       |    1 +
 drivers/pinctrl/pinctrl-exynos.c  |  108 +++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-samsung.c |    2 +
 drivers/pinctrl/pinctrl-samsung.h |    1 +
 5 files changed, 113 insertions(+)
