From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 28 Mar 2012 21:51:16 +0800
Subject: [GIT PULL] pull request from arch-pxa git on fixes branch
Message-ID: <CAN1soZytJ-CxepQAZn5oZ06=ezTQ85O-iC7tUDOeWqi=zpuf8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to pull fixes branch in arch-pxa git. This fix can resolve
build issues on updating regulator interface.

The following changes since commit c16fa4f2ad19908a47c63d8fa436a1178438c7e7:

  Linux 3.3 (2012-03-18 16:15:34 -0700)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git fixes

Paul Gortmaker (1):
      ARM: pxa: fix regulator related build fail in magician_defconfig

 arch/arm/mach-pxa/hx4700.c   |    2 --
 arch/arm/mach-pxa/magician.c |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)
