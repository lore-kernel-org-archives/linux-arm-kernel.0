From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 04 Feb 2013 15:42:01 -0800
Subject: [GIT PULL 5/5] Samsung cleanup for v3.9
Message-ID: <120f01ce0331$3b9f2790$b2dd76b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is for removing useless codes.
Please pull it.

Thanks.

- Kukjin

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/cleanup-samsung

for you to fetch changes up to 7cf580d03613b59fe4578e6717b0afd524ebad7b:

  ARM: S5PV210: remove useless ifdef in common.h (2013-02-04 14:35:48 -0800)

----------------------------------------------------------------
Kukjin Kim (3):
      ARM: dts: cleanup exynos5440.dtsi
      ARM: S5PC100: remove useless ifdef in common.h
      ARM: S5PV210: remove useless ifdef in common.h

 arch/arm/boot/dts/exynos5440.dtsi |    5 -----
 arch/arm/mach-s5pc100/common.h    |    9 ---------
 arch/arm/mach-s5pv210/common.h    |    9 ---------
 3 files changed, 23 deletions(-)
