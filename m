From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 Aug 2013 02:38:18 +0900
Subject: [GIT PULL] Samsung-fixes-2 for v3.11
Message-ID: <51FFE30A.5040800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:

   Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-2

for you to fetch changes up to 35f8550c8f27968af94ba5235cc611e3b6d86981:

   ARM: SAMSUNG: fix to support for missing cpu specific map_io 
(2013-07-30 13:30:57 +0900)

----------------------------------------------------------------
Fix to boot kernel on exynos5440 which has no specific map_io(). Current 
kernel
cannot support no CPU specific map_io() for Samsung SoCs.

----------------------------------------------------------------
Kukjin Kim (1):
       ARM: SAMSUNG: fix to support for missing cpu specific map_io

  arch/arm/plat-samsung/init.c | 5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)
