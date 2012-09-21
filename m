From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Sep 2012 15:22:43 +0900
Subject: [GIT PULL 3/4] Samsung devel for v3.7
Message-ID: <505C07B3.2040101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Here is Samsung development for v3.7 and most of them are updating.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:

   Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung

Chander Kashyap (3):
       ARM: EXYNOS: Turn off clocks for NAND, OneNAND and TSI controllers
       ARM: EXYNOS: Put PCM, Slimbus, Spdif clocks to off state
       ARM: SAMSUNG: Add check for NULL in clock interface

Leela Krishna Amudala (1):
       ARM: EXYNOS: Add bus clock for FIMD

Sachin Kamat (2):
       ARM: EXYNOS: Fix incorrect help text
       ARM: SAMSUNG: Fix HDMI related warnings

Sylwester Nawrocki (1):
       ARM: S3C24XX: Add .get_rate callback for "camif-upll" clock

  arch/arm/mach-exynos/Kconfig          |    4 ++--
  arch/arm/mach-exynos/clock-exynos4.c  |   31 
+++++++++++++++++++++++++++++++
  arch/arm/mach-exynos/clock-exynos5.c  |   32 
++++++++++++++++++++++----------
  arch/arm/mach-s3c24xx/clock-s3c2440.c |   14 ++++++++++++++
  arch/arm/plat-samsung/clock.c         |    8 ++++----
  arch/arm/plat-samsung/devs.c          |    3 ++-
  6 files changed, 75 insertions(+), 17 deletions(-)
