From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 7 Nov 2013 11:08:33 +0800
Subject: [PATCH 0/4] arm: make use of common scu_a9_get_base() interface
Message-ID: <1383793720-4643-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e9d6b3358ac35901ccc6a4a5a317670fa469db25 adds common APIs to
get scu base address from CP15. This patch series connverts some platforms
to use that interface.

Jisheng Zhang (4):
  arm: highbank: make use of common scu_a9_get_base() interface
  arm: imx: make use of common scu_a9_get_base() interface
  arm: prima2: make use of common scu_a9_get_base() interface
  arm: socfgpa: make use of common scu_a9_get_base() interface

 arch/arm/mach-highbank/highbank.c | 4 ++--
 arch/arm/mach-imx/platsmp.c       | 3 +--
 arch/arm/mach-prima2/platsmp.c    | 3 +--
 arch/arm/mach-socfpga/socfpga.c   | 4 ++--
 4 files changed, 6 insertions(+), 8 deletions(-)

-- 
1.8.4.2
