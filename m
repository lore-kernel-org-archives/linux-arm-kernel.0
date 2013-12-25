From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 25 Dec 2013 15:27:04 +0800
Subject: [GIT PULL][for 3.13] pull request on fix from pxa
Message-ID: <52BA88C8.1020605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please help to pull the fix.

Regards
Haojian

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git 
tags/fix-pxa

for you to fetch changes up to 17b7de0824891e29bfe6bc981543c6ca5123c519:

   ARM: pxa: fix USB gadget driver compilation regression (2013-12-11 
17:29:16 +0800)

----------------------------------------------------------------
Linus Walleij (1):
       ARM: pxa: fix USB gadget driver compilation regression

  arch/arm/mach-pxa/include/mach/lubbock.h | 2 ++
  1 file changed, 2 insertions(+)
