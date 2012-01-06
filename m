From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  6 Jan 2012 23:39:24 +0800
Subject: [PATCH v2 0/2] ARM: mxs: use CHIPID register to detect SoC
Message-ID: <1325864366-17995-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 * Define CHIPID register offset in digctl.h
 * Rename macro CHIPID to MXS_CHIPID
 * Remove mach-types.h inclusion from uncompress.h

Lauri Hintsala (1):
      ARM: mxs: Add initial support for Bluegiga APX4 Development Kit

Shawn Guo (1):
      ARM: mxs: detect SoC by checking CHIPID register

 arch/arm/mach-mxs/Kconfig                   |   16 ++
 arch/arm/mach-mxs/Makefile                  |    1 +
 arch/arm/mach-mxs/include/mach/digctl.h     |    1 +
 arch/arm/mach-mxs/include/mach/mxs.h        |   29 ++--
 arch/arm/mach-mxs/include/mach/uncompress.h |   13 +-
 arch/arm/mach-mxs/mach-apx4devkit.c         |  245 +++++++++++++++++++++++++++
 6 files changed, 285 insertions(+), 20 deletions(-)
