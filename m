From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 5 Jun 2012 17:58:17 +0800
Subject: [GIT PULL] [for 3.5] pull request of fixes branch on arch-pxa tree
Message-ID: <CAN1soZw-j8urHx1uikeN9eR2BE7+QKk5MNFQitn-7p6CM4Q1hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Arnd,

Please help to pull fixes branch in arch-pxa git tree.

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git fixes

Haojian Zhuang (2):
      ARM: dts: update memory size on brownstone
      ARM: mmp: fix missing cascade_irq in irq handler

 arch/arm/boot/dts/mmp2-brownstone.dts |    4 ++--
 arch/arm/mach-mmp/irq.c               |    7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

Best Regards
Haojian
