From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 23 Nov 2012 17:33:29 +0800
Subject: [GIT PULL][for 3.8] pull request from arch pxa tree on armsoc/fix
Message-ID: <CAN1soZx3fXEaryZYj7-s4aABF+kfkMpG595uteCwGh2eTsx1GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Arnd,

Please help to merge armsoc/fix branch in arch pxa git tree.

It's just a new fix and it's not essential to us, I put it on the fix
branch that you just pulled. You only need to pick up this commit in
below.

Regards
Haojian

The following changes since commit 8757e168190a6ed2cd4aa23fc59bf86b0091b596:

  ARM: pxa: fix pxa25x gpio wakeup setting (2012-11-21 13:14:42 +0800)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git armsoc/fix

for you to fetch changes up to d90cb69ddd032854b633c4069ba3493651cb8ebc:

  ARM: pxa: add dummy SA1100 rtc clock in pxa25x (2012-11-23 17:27:41 +0800)

----------------------------------------------------------------
Andrea Adami (1):
      ARM: pxa: add dummy SA1100 rtc clock in pxa25x

 arch/arm/mach-pxa/pxa25x.c |    1 +
 1 file changed, 1 insertion(+)
