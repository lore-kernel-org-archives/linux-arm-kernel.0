From: octavian.purdila@nxp.com (Octavian Purdila)
Date: Fri, 21 Oct 2016 10:18:19 +0300
Subject: [PATCH 0/2] ARM: imx: init MAC address for ocotp
Message-ID: <1477034301-26579-1-git-send-email-octavian.purdila@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for initializing the ethernet MAC
address for the OCOTP fuse configuration.

Fugang Duan (1):
  ARM: imx: init enet MAC address from ocotp

Octavian Purdila (1):
  ARM: imx: add ocotp support in machine code

 arch/arm/mach-imx/Kconfig       |   5 ++
 arch/arm/mach-imx/Makefile      |   1 +
 arch/arm/mach-imx/common.h      |   3 ++
 arch/arm/mach-imx/mach-imx6q.c  |  32 ++++--------
 arch/arm/mach-imx/mach-imx6sl.c |  12 +++--
 arch/arm/mach-imx/mach-imx6sx.c |   2 +
 arch/arm/mach-imx/mach-imx7d.c  |   2 +
 arch/arm/mach-imx/ocotp.c       | 113 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 146 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/mach-imx/ocotp.c

-- 
2.7.4
