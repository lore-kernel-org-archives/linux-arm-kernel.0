From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 4 Jul 2012 16:06:07 +0800
Subject: [GIT PULL][for 3.5] pull request of fixes branch from pxa git tree
Message-ID: <CAN1soZxZAnWU=3c7JV5vr2F71+KrDRN+DN_hEezjS7b_hARsdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Arnd,

Please help to pull fixes branch from pxa git tree. Now commit
c12a3cb9dca9676 is appended.

Regards
Haojian


The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git fixes

for you to fetch changes up to c12a3cb9dca96768a5f048bb50f3395216346bda:

  ARM: mmp: remove mach/gpio-pxa.h (2012-07-04 15:58:11 +0800)

----------------------------------------------------------------
Paul Bolle (1):
      ARM: mmp: remove mach/gpio-pxa.h

Paul Parsons (1):
      ARM: pxa: hx4700: Fix basic suspend/resume

 arch/arm/mach-mmp/include/mach/gpio-pxa.h |   29 -----------------------------
 arch/arm/mach-pxa/hx4700.c                |   15 ++++++++++++++-
 2 files changed, 14 insertions(+), 30 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/gpio-pxa.h
