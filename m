From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 03:19:52 +0900
Subject: [GIT PULL 09/10] 2nd timer-samsung for v3.10
Message-ID: <51630A48.1060401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ad38bdd15d5b97dcb1ffc46ea77c237e30312fbb:

   ARM: SAMSUNG: Remove unused plat-samsung/time.c (2013-03-05 20:19:54 
+0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/timer-samsung-for-v3.10

for you to fetch changes up to 536504309c3c2da5a755263c7179ffe1b2e5b3dd:

   ARM: SAMSUNG: change GENERIC_GPIO to ARCH_REQUIRE_GPIOLIB (2013-04-04 
09:36:24 +0900)

----------------------------------------------------------------
including fix for GENERIC_GPIO based on previous pull-request for 
timer-samsung

----------------------------------------------------------------
Kukjin Kim (1):
       ARM: SAMSUNG: change GENERIC_GPIO to ARCH_REQUIRE_GPIOLIB

  arch/arm/Kconfig | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
