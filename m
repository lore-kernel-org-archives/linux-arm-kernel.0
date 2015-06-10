From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 10 Jun 2015 15:38:48 +0800
Subject: [GIT PULL] CSR SiRFSoC rtc iobrg move to regmap for 4.2
Message-ID: <CAGsJ_4xsKduEjSEZdzRfcSOW=bCa8yb03HWakQrBM0q2YmqEdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,


The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/sirf-iobrg2regmap-for-4.2

for you to fetch changes up to b1999477ed91c3c33891acfe0e18a4457e5c4915:

  ARM: prima2: move to use REGMAP APIs for rtciobrg (2015-06-10 15:10:26 +0800)

----------------------------------------------------------------
move CSR rtc iobrg read/write API to be regmap

this moves to general APIs, and all drivers will be changed based
on it.

----------------------------------------------------------------
Guo Zeng (1):
      ARM: prima2: move to use REGMAP APIs for rtciobrg

 arch/arm/mach-prima2/Kconfig         |    1 +
 arch/arm/mach-prima2/rtciobrg.c      |   48 +++++++++++++++++++++++++++++++---
 include/linux/rtc/sirfsoc_rtciobrg.h |    4 +++
 3 files changed, 50 insertions(+), 3 deletions(-)

-barry
