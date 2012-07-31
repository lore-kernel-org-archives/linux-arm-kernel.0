From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 31 Jul 2012 09:39:55 +0800
Subject: [GIT PULL][for 3.6] pull request from board branch in pxa git tree
Message-ID: <CAN1soZxxZMy7iVx=r1XwaxfXVLAXBGd03t5rv7PM4A7dQm_HFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to pull these from board branch of pxa git tree for v3.6

Regards
Haojian

The following changes since commit 28a33cbc24e4256c143dce96c7d93bf423229f92:

  Linux 3.5 (2012-07-21 13:58:29 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git board

for you to fetch changes up to b168c113cb4be1352465d04a9828a0af2300410b:

  ARM: mmp: add missing irqs.h (2012-07-31 09:36:44 +0800)

----------------------------------------------------------------
Haojian Zhuang (1):
      ARM: mmp: add missing irqs.h

Lei Wen (1):
      ARM: ttc_dkb: add nand support

 arch/arm/mach-mmp/gplugd.c  |    1 +
 arch/arm/mach-mmp/ttc_dkb.c |   10 ++++++++++
 2 files changed, 11 insertions(+)
