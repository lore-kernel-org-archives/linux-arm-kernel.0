From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 9 Sep 2012 20:11:14 +0800
Subject: [GIT PULL][for 3.7] pull requst of board branch in arch pxa
Message-ID: <CAN1soZyXD7Zucp=LvhXVpaid4YUXd5punrF9mco0N5GtcQ=gzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to merge board branch of arch pxa git tree.

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git board

for you to fetch changes up to ec9b22eebbcf6ff1dfc121ec1e76bbb98a0418b4:

  ARM: mmp: enable debug uart port in defconfig (2012-08-16 17:49:08 +0800)

----------------------------------------------------------------
Haojian Zhuang (2):
      ARM: mmp: implement DEBUG_LL port choice
      ARM: mmp: enable debug uart port in defconfig

 arch/arm/Kconfig.debug                       |   14 ++++++++++++++
 arch/arm/configs/mmp2_defconfig              |    5 ++++-
 arch/arm/configs/pxa910_defconfig            |    4 +++-
 arch/arm/mach-mmp/include/mach/debug-macro.S |   12 ++++++++++--
 4 files changed, 31 insertions(+), 4 deletions(-)
