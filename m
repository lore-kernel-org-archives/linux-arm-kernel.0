From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 16 Aug 2012 15:57:10 +0800
Subject: [GIT PULL][for 3.6] pull request from fixes branch in pxa git tree
Message-ID: <CAN1soZw8UC-R0hq4CgsGG20-42z0jYUvbTygF18rn+hhmtJivQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Arnd,

Please help to pull fixes branch from pxa git tree.

Regards
Haojian

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git fixes

for you to fetch changes up to c0db19dabf138741e078f6391fb132821c0d98b5:

  ARM: mmp: fix potential NULL dereference (2012-08-10 22:32:24 +0800)

----------------------------------------------------------------
Yuanhan Liu (1):
      ARM: mmp: fix potential NULL dereference

 arch/arm/mach-mmp/sram.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
