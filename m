From: ruslan.bilovol@ti.com (Ruslan Bilovol)
Date: Thu, 31 Jan 2013 21:24:42 +0200
Subject: [PATCH 0/2] ARM: OMAP2+: Export SoC information to userspace using
 SoC infrastructure
Message-ID: <1359660284-5225-1-git-send-email-ruslan.bilovol@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series is an attempt to export some OMAP SoC
information (like name, revision etc.) to userspace.
The first patch does some unification of OMAP SoC
information representation in current sources.
Second patch adds exactly needed changes using
exists in Linux kernel SoC infrastructure.

Ruslan Bilovol (2):
  ARM: OMAP2+: SoC name and revision unification
  ARM: OMAP2+: Export SoC information to userspace

 arch/arm/mach-omap2/Kconfig  |    1 +
 arch/arm/mach-omap2/common.h |    8 +++
 arch/arm/mach-omap2/id.c     |  152 ++++++++++++++++++++++++++++++++----------
 arch/arm/mach-omap2/io.c     |    1 +
 4 files changed, 125 insertions(+), 37 deletions(-)

-- 
1.7.9.5
