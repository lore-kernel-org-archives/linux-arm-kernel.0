From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 20 May 2012 07:43:01 +0900
Subject: [GIT PULL] Samsung board-2 for v3.5
Message-ID: <4FB821F5.1070308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull 2nd Samsung board stuff from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/board-samsung-2

It includes updating of Cragganmore board(S3C64XX).

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
next/board-samsung-2

Mark Brown (2):
       ARM: S3C64XX: Initial hookup for Bells module on Cragganmore
       ARM: S3C64XX: Hook up carrier class modules on Cragganmore

  arch/arm/mach-s3c64xx/mach-crag6410-module.c |    9 ++++++++-
  arch/arm/mach-s3c64xx/mach-crag6410.c        |    1 +
  2 files changed, 9 insertions(+), 1 deletions(-)
