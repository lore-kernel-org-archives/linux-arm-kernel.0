From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 4 Apr 2014 15:40:26 +0530
Subject: [PATCH v2 0/3] ARM: OMAP2+: AM437x: L2 cache support
Message-ID: <cover.1396605300.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds L2 cache support for AM437x
and does some clean-ups for existing OMAP4 support
along the way.

Tested on OMAP4 Panda and AM437x EPOS EVMs.

It is based on RMK's 75 patch series titled "l2c series".

Sekhar Nori (3):
  ARM: OMAP2+: L2 cache: allow different aux ctrl settings
  ARM: OMAP2+: L2 cache: get rid of init call
  ARM: OMAP2+: AM43x: L2 cache support

 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/common.h       |    2 ++
 arch/arm/mach-omap2/io.c           |    2 ++
 arch/arm/mach-omap2/omap4-common.c |   45 +++++++++++++++++++-----------------
 4 files changed, 29 insertions(+), 21 deletions(-)

-- 
1.7.10.1
