From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 07 Mar 2013 11:23:32 +0900
Subject: [GIT PULL 2/5] Samsung cleanup-s5p for v3.10
Message-ID: <016701ce1ada$c35e6860$4a1b3920$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is small cleanup for s5p stuff.

This is including useless ifdef.

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
next/cleanup-s5p

for you to fetch changes up to eb50cd0b2a083950457bf68241a9f040972b6908:

  ARM: S5PV210: remove useless ifdef in common.h (2013-03-05 18:37:10 +0900)

----------------------------------------------------------------
Kukjin Kim (2):
      ARM: S5PC100: remove useless ifdef in common.h
      ARM: S5PV210: remove useless ifdef in common.h

 arch/arm/mach-s5pc100/common.h |    9 ---------
 arch/arm/mach-s5pv210/common.h |    9 ---------
 2 files changed, 18 deletions(-)
