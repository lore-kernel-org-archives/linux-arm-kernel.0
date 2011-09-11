From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 11 Sep 2011 09:36:19 +0800
Subject: [GIT PULL] CSR prima2 changes for next
Message-ID: <CAGsJ_4xv3eeZtp_GEnifk3MpF=gaNRe=wVzLiojo=Jgy4qRePA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
can you please pull the 1st patchset of CSR prima2 for next? most of
them are minor changes except that rtciobrg is new stuff.

The following changes since commit ddf28352b80c86754a6424e3a61e8bdf9213b3c7:
  Linus Torvalds (1):
        Linux 3.1-rc5

are available in the git repository at:

  git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git for-arnd

Barry Song (3):
      ARM: CSR: add lost Resource Sharing Control(RSC) node in dts
      ARM: CSR: extend the compatibility of gpio controller to pinmux in dts
      ARM: CSR: IRQ: add simple irq_domain so that hw irq can map to Linux

Jamie Iles (1):
      ARM: CSR: add missing sentinels to of_device_id tables

Zhiwu Song (1):
      ARM: CSR: add rtc i/o bridge interface for SiRFprimaII

 arch/arm/boot/dts/prima2-cb.dts      |    9 ++-
 arch/arm/mach-prima2/Makefile        |    1 +
 arch/arm/mach-prima2/clock.c         |    1 +
 arch/arm/mach-prima2/irq.c           |    4 +
 arch/arm/mach-prima2/rstc.c          |    1 +
 arch/arm/mach-prima2/rtciobrg.c      |  139 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-prima2/timer.c         |    1 +
 include/linux/rtc/sirfsoc_rtciobrg.h |   18 +++++
 8 files changed, 172 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-prima2/rtciobrg.c
 create mode 100644 include/linux/rtc/sirfsoc_rtciobrg.h

Thanks
barry
