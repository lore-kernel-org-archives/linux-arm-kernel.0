From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Sep 2012 15:22:18 +0900
Subject: [GIT PULL 2/4] Samsung pinctrl-2 for v3.7
Message-ID: <505C079A.8020801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

This is for fix typo and correct fucntion for Samsung pinctrl and since 
this has a dependency with previous pinctrl branch I created this based 
on that.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 011527b45f8e3092e1f3192e5aea94187a6ca269:

   ARM: EXYNOS: Enable pinctrl driver support for EXYNOS4 device tree 
enabled platform (2012-09-07 06:14:26 +0900)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/pinctrl-samsung-2

Tomasz Figa (7):
       pinctrl: exynos: Set pin function to EINT in irq_set_type of GPIO 
EINTa
       pinctrl: exynos: Fix typos in gpio/wkup _irq_mask
       pinctrl: exynos: Handle only unmasked wakeup interrupts
       pinctrl: exynos: Mark exynos_irq_demux_eint as inline
       pinctrl: exynos: Correct the detection of wakeup-eint node
       pinctrl: samsung: Uninline samsung_pinctrl_get_soc_data
       pinctrl: exynos: Fix wakeup IRQ domain registration check

  drivers/pinctrl/pinctrl-exynos.c  |   41 
+++++++++++++++++++++++++++----------
  drivers/pinctrl/pinctrl-exynos.h  |    1 +
  drivers/pinctrl/pinctrl-samsung.c |    2 +-
  3 files changed, 32 insertions(+), 12 deletions(-)
