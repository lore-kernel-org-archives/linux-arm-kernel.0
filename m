From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 5 Dec 2011 12:49:11 +0000
Subject: [GIT PULL] DaVinci fixes for v3.2-rc
Message-ID: <DF0F476B391FA8409C78302C7BA518B603B5F2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following DaVinci fixes for
the next v3.2-rc release. None of these are
v3.2 regressions, but I have marked only two
of these with stable tag since rest are not
very critical.

Thanks,
Sekhar

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:
  Linus Torvalds (1):
        Linux 3.2-rc4

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git fixes

Hans Verkuil (1):
      ARM: davinci: dm646x evm: wrong register used in setup_vpif_input_channel_mode

Manjunathappa, Prakash (1):
      ARM: davinci: da850 evm: change audio edma event queue to EVENTQ_0

Murali Karicheri (2):
      ARM: davinci: psc: fix incorrect mask
      ARM: davinci: psc: fix incorrect offsets

Sekhar Nori (1):
      ARM: davinci: dm646x does not have a DSP domain

Shankarmurthy,Akshay (1):
      ARM: davinci: dm365 evm: align nand partition table to u-boot

 arch/arm/mach-davinci/board-da850-evm.c  |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c  |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c |    6 +++---
 arch/arm/mach-davinci/dm646x.c           |    1 -
 arch/arm/mach-davinci/include/mach/psc.h |    5 ++++-
 arch/arm/mach-davinci/psc.c              |   18 +++++++++---------
 6 files changed, 18 insertions(+), 16 deletions(-)
