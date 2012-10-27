From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 28 Oct 2012 07:57:55 +0800
Subject: [GIT PULL][for 3.7] pull request from upload/fix in arch-pxa git tree
Message-ID: <CAN1soZxgXGFNqnFMM5ZaAf6tpbxPBFdmr8BqHJpOxUGVr08W=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Arnd,

Please help to pull upload/fix branch from arch-pxa git tree.

Best Regards
Haojian

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git upload/fix

for you to fetch changes up to 510fcb0d331f314cd20d0067d56f29302846f47b:

  ARM: pxa/spitz_pm: Fix hang when resuming from STR (2012-10-28 07:53:45 +0800)

----------------------------------------------------------------
Marko Katic (1):
      ARM: pxa/spitz_pm: Fix hang when resuming from STR

Paul Parsons (1):
      ARM: pxa: hx4700: Fix backlight PWM device number

 arch/arm/mach-pxa/hx4700.c   |    8 +++++++-
 arch/arm/mach-pxa/spitz_pm.c |    8 ++------
 2 files changed, 9 insertions(+), 7 deletions(-)
