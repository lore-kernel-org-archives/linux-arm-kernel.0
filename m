From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 14 Sep 2010 16:16:10 +0800
Subject: [GIT PULL] pxa fixes for 2.6.36-rc4
Message-ID: <AANLkTinQOrJM4VGbmcjrfahsFRKCDxoHhzskN-KHNYDH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 49553c2ef88749dd502687f4eb9c258bb10a4f44:
  Linus Torvalds (1):
        Linux 2.6.36-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Eric Miao (1):
      ARM: pxa: fix cpu_is_pxa*() not expanding to zero when not configured

Haojian Zhuang (1):
      ARM: pxa168fb: clear enable bit when not active

Joe Perches (1):
      ARM: pxa: remove pr_<level> uses of KERN_<level>

Marek Vasut (3):
      ARM: pxa: Disperse Balloon3 MFP config
      ARM: pxa: Fix Vpac270 gpio_power for MMC
      ARM: pxa: Use PIO for PI2C communication on Palm27x

Mark F. Brown (1):
      ARM: pxa168: fix corrected reset vector

 arch/arm/mach-mmp/include/mach/system.h   |    7 ++-
 arch/arm/mach-pxa/balloon3.c              |  104 +++++++++++++++++++----------
 arch/arm/mach-pxa/cpufreq-pxa2xx.c        |    3 +-
 arch/arm/mach-pxa/include/mach/hardware.h |   12 +++
 arch/arm/mach-pxa/palm27x.c               |    6 ++-
 arch/arm/mach-pxa/vpac270.c               |    1 +
 drivers/video/pxa168fb.c                  |    4 +-
 7 files changed, 95 insertions(+), 42 deletions(-)
