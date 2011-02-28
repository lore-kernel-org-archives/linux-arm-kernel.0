From: khilman@ti.com (Kevin Hilman)
Date: Mon, 28 Feb 2011 15:41:36 -0800
Subject: [GIT PULL] davinci fixes for 2.6.38-rc7
Message-ID: <87oc5vlob3.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the following small series of davinci fixes for 2.6.38-rc7.

Thanks,

Kevin


The following changes since commit f5412be599602124d2bdd49947b231dd77c0bf99:

  Linux 2.6.38-rc6 (2011-02-21 17:25:52 -0800)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git davinci-fixes

Axel Lin (1):
      davinci: cpufreq: fix section mismatch warning

Hirosh Dabui (1):
      davinci: tnetv107x: fix register indexing for GPIOs numbers > 31

Rajashekhara, Sudhakar (1):
      davinci: da8xx/omap-l1x: add platform device for davinci-pcm-audio

Sergei Shtylyov (1):
      DaVinci: fix compilation warnings in <mach/clkdev.h>

 arch/arm/mach-davinci/cpufreq.c             |    2 +-
 arch/arm/mach-davinci/devices-da8xx.c       |    7 +++++++
 arch/arm/mach-davinci/gpio-tnetv107x.c      |   18 +++++++++---------
 arch/arm/mach-davinci/include/mach/clkdev.h |    2 ++
 4 files changed, 19 insertions(+), 10 deletions(-)
