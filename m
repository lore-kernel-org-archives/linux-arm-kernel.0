From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 08:46:38 +0200
Subject: remove several ARCH_MX* macros from arch/arm
Message-ID: <1314168400-14889-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARCH_MX* and MACH_MX* macros are scheduled for removal. Get
rid of some of them in arch/arm/

Sascha Hauer (2):
      ARM i.MX: remove ARCH_MX* macros from Makefile
      ARM i.MX audmux v2: remove unnecessary ifdefs

 arch/arm/mach-imx/Makefile    |   10 +++++-----
 arch/arm/plat-mxc/audmux-v2.c |   18 ++++--------------
 2 files changed, 9 insertions(+), 19 deletions(-)
