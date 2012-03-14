From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 14 Mar 2012 18:30:24 +0800
Subject: [GIT PULL][for v3.4] pull request from board-specific branch in
 arch-pxa
Message-ID: <CAN1soZyWmrzQzr0VHtrixdr2myv4ggJ1YBcS8OnuLJLOn2uVEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

First, please help to _revert_ one commit 43de6a7dda6e9a7345e2 on
arnd/pxa/board branch of arm-soc.git first. Since this commit is
duplicated, and it's already merged into v3.3-rc7. I'm sorry on
inconvenience.

commit 43de6a7dda6e9a7345e218e688f2092f991126f0
Author: Haojian Zhuang <haojian.zhuang@marvell.com>
Date:   Tue Feb 28 10:57:48 2012 +0800

    ARM: pxa: add dummy clock for pxa25x and pxa27x


Second, please help to pull these commits from arch-pxa git tree.

The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:

  Linux 3.3-rc7 (2012-03-10 13:49:52 -0800)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git board-specific

Paul Parsons (3):
      ARM: pxa/hx4700: Remove unwanted request for GPIO105
      ARM: pxa/hx4700: Reduce sleep mode battery discharge by 35%
      pxa/hx4700: Remove pcmcia platform_device structure

 arch/arm/mach-pxa/hx4700.c                  |   17 ++---------------
 arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    2 ++
 2 files changed, 4 insertions(+), 15 deletions(-)


Best Regards
Haojian
