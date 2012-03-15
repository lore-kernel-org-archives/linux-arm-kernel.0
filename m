From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 15 Mar 2012 07:25:20 -0700
Subject: [GIT PULL] Samsung EXYNOS5250 GPIO for v3.4
Message-ID: <4F61FBD0.4040904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull EXYNOS5250 gpio for v3.4.

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/soc-exynos5250-gpio

It is including add support GPIOlib for EXYNOS5250 and Grant Likely 
already agreed to send this via arm-soc for v3.4. Actually, this is 
needed for compilation of EXYNOS5250 arch. As a note, this has no 
dependency with others for merging.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:

   Linux 3.3-rc7 (2012-03-10 13:49:52 -0800)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/soc-exynos5250-gpio

Sangsu Park (3):
       ARM: EXYNOS: add support GPIO for EXYNOS5250
       gpio/samsung: add support GPIOlib for EXYNOS5250
       gpio/samsung: use ioremap() for EXYNOS4 GPIOlib

  arch/arm/mach-exynos/common.c            |   15 -
  arch/arm/mach-exynos/include/mach/gpio.h |  239 ++++++++++++---
  arch/arm/mach-exynos/include/mach/map.h  |    4 +
  drivers/gpio/gpio-samsung.c              |  487 
+++++++++++++++++++++++++++---
  4 files changed, 637 insertions(+), 108 deletions(-)
