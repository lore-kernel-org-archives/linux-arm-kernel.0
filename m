From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 3 Jun 2013 14:28:48 +0800
Subject: [GIT PULL] SiRF fixes for the v3.10 series
Message-ID: <CAGsJ_4xTVms1wZVgBDE-+qZMGxKT4s_u-A=wXiB2Xq0NztpOUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git
tags/sirf-arm-soc-v3.10-fixes

for you to fetch changes up to 3cc3b617dc39dad1e566ccfc4500154cb7c51aa3:

  arm: prima2: use of_platform_populate instead of
of_platform_bus_probe (2013-06-03 13:51:58 +0800)

----------------------------------------------------------------
SiRF fixes for V3.10

- Replace include linux/module.h with linux/export.h
- fix a checkpatch issue
- use of_platform_populate instead of of_platform_bus_probe

----------------------------------------------------------------
Barry Song (2):
      ARM: prima2: fix a checkpatch issue
      arm: prima2: use of_platform_populate instead of of_platform_bus_probe

Syam Sidhardhan (1):
      ARM: prima2: Replace include linux/module.h with linux/export.h

 arch/arm/mach-prima2/common.c | 17 ++---------------
 arch/arm/mach-prima2/pm.c     |  2 +-
 2 files changed, 3 insertions(+), 16 deletions(-)
