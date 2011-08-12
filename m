From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 12 Aug 2011 15:56:12 +0530
Subject: [PATCH 0/2] Fixes for S5PV210 PM
Message-ID: <1313144774-30607-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes a compilation warning and removes an unwanted
Kconfig symbol.

Abhilash Kesavan (2):
  ARM: S5PV210: Fix build warning
  ARM: S5PV210: Remove unncessary symbol for PM

 arch/arm/mach-s5pv210/Kconfig  |    6 ------
 arch/arm/mach-s5pv210/Makefile |    2 +-
 arch/arm/mach-s5pv210/pm.c     |    2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

--
1.7.4.1
