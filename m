From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Nov 2012 09:16:22 +0900
Subject: [GIT PULL 7/7] Samsung boards-2 for v3.8
Message-ID: <50B557D6.3050109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof

This is for Samsung board updates just for s3c64xx

This is based on next/board-samsung branch is already included in 
arm-soc tree.

Please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/board-samsung-2

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 5a7eb8e4fedc03b5c511a61986bff6f6d31c693f:

   ARM: S3C64XX: Add missing device selects for Cragganmore (2012-11-20 
20:13:58 +0900)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/board-samsung-2

Mark Brown (2):
       ARM: S3C64XX: Add registration of WM2200 Bells device on Cragganmore
       ARM: S3C64XX: Add dummy supplies for Glenfarclas LDOs

  arch/arm/mach-s3c64xx/mach-crag6410.c |   20 ++++++++++++++++++--
  1 files changed, 18 insertions(+), 2 deletions(-)
