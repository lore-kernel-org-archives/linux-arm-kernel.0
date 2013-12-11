From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 11 Dec 2013 16:40:26 +0800
Subject: [GIT PULL][for 3.14] pull request for mmp
Message-ID: <52A824FA.3070405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please help to merge pull request for mmp.

Best Regards
Haojian

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git 
tags/mmp-for-3.14

for you to fetch changes up to fb4524e6f3a173730911a121f5b2c0c717d980c9:

   arm: mmp: build sram driver alone (2013-12-06 15:34:11 +0800)

----------------------------------------------------------------
Qiao Zhou (1):
       arm: mmp: build sram driver alone

  arch/arm/mach-mmp/Kconfig  | 3 +++
  arch/arm/mach-mmp/Makefile | 3 ++-
  drivers/dma/Kconfig        | 2 ++
  3 files changed, 7 insertions(+), 1 deletion(-)
