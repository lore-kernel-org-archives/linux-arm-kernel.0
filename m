From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 15 Apr 2013 22:53:18 +0530
Subject: [GIT PULL 2/3] ARM: davinci: SoC updates for v3.10 (part 2)
In-Reply-To: <1366046599-6590-1-git-send-email-nsekhar@ti.com>
References: <1366046599-6590-1-git-send-email-nsekhar@ti.com>
Message-ID: <1366046599-6590-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please the following SoC updates for DaVinci.
The branch depends on (and merges) an immutable branch
from Ohad adding DA8XX rempote proc driver.

Thanks,
Sekhar

The following changes since commit a0e5cda94cf0fab47a9bc87c50bce7f5cd26acda:

  Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc into v3.10/soc (2013-04-15 14:37:45 +0530)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.10/soc-2

for you to fetch changes up to 1511a86e71baebc7b27da5f52cbaf3272f13d556:

  ARM: davinci: ensure global variables are declared (2013-04-15 15:13:13 +0530)

----------------------------------------------------------------
v3.10 SoC updates for DaVinci

This set of patches add support for remoteproc
used to control the DSP and also fix sparse
errors existing for quite some time.

----------------------------------------------------------------
Robert Tivy (1):
      ARM: davinci: da8xx: add remoteproc support

Sekhar Nori (3):
      ARM: davinci: da8xx dt: make file local symbols static
      ARM: davinci: sram.c: fix incorrect type in assignment
      ARM: davinci: ensure global variables are declared

 Documentation/kernel-parameters.txt        |    6 ++
 arch/arm/mach-davinci/da8xx-dt.c           |    4 +-
 arch/arm/mach-davinci/devices-da8xx.c      |   88 +++++++++++++++++++++++++++-
 arch/arm/mach-davinci/include/mach/da8xx.h |    4 ++
 arch/arm/mach-davinci/pm.c                 |    1 +
 arch/arm/mach-davinci/sram.c               |    4 +-
 arch/arm/mach-davinci/usb.c                |    1 +
 7 files changed, 103 insertions(+), 5 deletions(-)
