From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Apr 2014 13:58:00 +0530
Subject: [PATCH v3 0/3] ARM: OMAP2+: AM437x: L2 cache support
Message-ID: <cover.1398149526.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds L2 cache support for AM437x
and does some clean-ups for existing OMAP4 support
along the way (no functional changes). On OMAP4 Panda,
the Aux control value remains 0x7e470000 before and
after the series.

Tested on OMAP4 Panda and AM437x EPOS EVMs.

It is based on RMK's 75 patch series titled "l2c series" +
the patch contained in https://www.mail-archive.com/linux-omap at vger.kernel.org/msg103439.html

Sekhar Nori (3):
  ARM: OMAP2+: L2 cache: get rid of init call
  ARM: OMAP2+: L2 cache: git rid of redundant cache replacement policy
    setting
  ARM: OMAP2+: AM43x: L2 cache support

 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/common.h       |    1 +
 arch/arm/mach-omap2/io.c           |    2 ++
 arch/arm/mach-omap2/omap4-common.c |   17 ++++-------------
 4 files changed, 8 insertions(+), 13 deletions(-)

-- 
1.7.10.1
