From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Dec 2013 09:41:12 +0100
Subject: [GIT PULL] U300 patches for v3.14
Message-ID: <CACRpkdaU9rjciuJKkFAuQRZ3+8C6kybiUECg-4j4=EtcJUUD8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a set of three U300 patches for the v3.14 series. Nothing major,
and not motivating to be split up due to the small amount of traffic since
we moved U300 to multiplatform.

You may want to pull this into a place where Uwe's stuff for timex.h
removal also ends up so everything is resolved nicely.

Please pull it into ARM SoC!

Yours,
Linus Walleij


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/u300-for-arm-soc-1

for you to fetch changes up to 6a79799d5654bb7800614e8b7a009252be7ff90e:

  ARM: u300: fix timekeeping when periodic mode is used (2013-11-26
21:00:21 +0100)

----------------------------------------------------------------
Misc U300 development for the v3.14 series:

- Timekeeping patch from Uwe.

- DT 0x0 cleanup from Lee.

- Return value check from Wei.

----------------------------------------------------------------
Lee Jones (1):
      ARM: u300: Remove '0x's from U300 DTS file

Uwe Kleine-K?nig (1):
      ARM: u300: fix timekeeping when periodic mode is used

Wei Yongjun (1):
      ARM: u300: fix return value check in __u300_init_boardpower()

 arch/arm/boot/dts/ste-u300.dts |  6 +++---
 arch/arm/mach-u300/regulator.c |  4 ++--
 arch/arm/mach-u300/timer.c     | 38 ++++++++++++++++++++++++--------------
 3 files changed, 29 insertions(+), 19 deletions(-)
