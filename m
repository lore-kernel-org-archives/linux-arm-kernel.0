From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 22 Aug 2013 01:30:13 +0530
Subject: [GIT PULL 2/2] DaVinci DT updates for v3.12
In-Reply-To: <52151BA6.2060109@ti.com>
References: <52151BA6.2060109@ti.com>
Message-ID: <52151C4D.2000408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

Please pull the following DaVinci DT updates for v3.12.
It depends on the SoC updates in 1/2

Thanks,
Sekhar

The following changes since commit 46c1833467c5e555f31cd6f14b342a7383f26885:

  ARM: davinci: fix clock lookup for mdio device (2013-08-22 00:39:01 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.12/dt

for you to fetch changes up to 29864962f79e3dab645a5b00ccc7d4da96e9db33:

  ARM: davinci: da850: do not specify clock_frequency for UART DT node (2013-08-22 00:44:58 +0530)

----------------------------------------------------------------
DaVinci DT updates for v3.12
----------------------------

This set of patches add ethernet DT nodes
for DA850 and also remove now unneeded
specification of UART clock frequency so
kernel can now boot irrespective of what
the bootloader setting of UART frequency is.

----------------------------------------------------------------
Lad, Prabhakar (4):
      ARM: davinci: da850: add DT node for mdio device
      ARM: davinci: da850: add OF_DEV_AUXDATA entry for mdio.
      ARM: davinci: da850: add OF_DEV_AUXDATA entry for davinci_emac
      ARM: davinci: da850: add DT node for ethernet

Manjunathappa, Prakash (1):
      ARM: davinci: da850: do not specify clock_frequency for UART DT node

 arch/arm/boot/dts/da850-evm.dts  |   11 +++++++++
 arch/arm/boot/dts/da850.dtsi     |   46 +++++++++++++++++++++++++++++++++++---
 arch/arm/mach-davinci/da8xx-dt.c |    3 +++
 3 files changed, 57 insertions(+), 3 deletions(-)
