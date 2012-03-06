From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 6 Mar 2012 15:01:58 +0800
Subject: [GIT PULL][v3.3] pull request on arch-pxa tree with fix branch
Message-ID: <CAN1soZzkb9qWmBRsv_wEwHwiRUW+q7zaehxnMifgEhsoXV4BZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please help to pull these patch in fixes branch of arch-pxa tree.

Best Regards
Haojian

The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:

  Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git fixes

Haojian Zhuang (3):
      ARM: pxa: add dummy clock for pxa25x and pxa27x
      ARM: pxa: remove duplicated registeration on pxa-gpio
      ARM: pxa: fix invalid mfp pin issue

 arch/arm/mach-pxa/generic.h    |    1 -
 arch/arm/mach-pxa/mfp-pxa2xx.c |    7 +++++++
 arch/arm/mach-pxa/pxa25x.c     |    2 +-
 arch/arm/mach-pxa/pxa27x.c     |    2 +-
 arch/arm/mach-pxa/pxa3xx.c     |    1 -
 arch/arm/mach-pxa/pxa95x.c     |    1 -
 6 files changed, 9 insertions(+), 5 deletions(-)
You have new mail in /var/spool/mail/hzhuang1
