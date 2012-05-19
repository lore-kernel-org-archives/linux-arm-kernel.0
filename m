From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 20 May 2012 07:26:50 +0900
Subject: [GIT PULL] Samsung cleanup-2 for v3.5
Message-ID: <4FB81E2A.1050806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull Samsung cleanup-2 for v3.5 from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cleanup-samsung-2

It is including cleanup of s3c64xx-cpuidle to use new api and has no 
dependency with other branches.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 36be50515fe2aef61533b516fa2576a2c7fe7664:

   Linux 3.4-rc7 (2012-05-12 18:37:47 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cleanup-samsung-2

Daniel Lezcano (2):
       ARM: S3C64XX: declare the states with the new api on cpuidle
       ARM: S3C64XX: use timekeeping wrapper on cpuidle

  arch/arm/mach-s3c64xx/cpuidle.c |   45 
+++++++++++++--------------------------
  1 files changed, 15 insertions(+), 30 deletions(-)
