From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 Apr 2013 23:15:57 +0530
Subject: [GIT PULL v2 2/3] ARM: davinci: SoC updates for v3.10 (part 2)
In-Reply-To: <1366220758-23373-1-git-send-email-nsekhar@ti.com>
References: <1366220758-23373-1-git-send-email-nsekhar@ti.com>
Message-ID: <1366220758-23373-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following SoC updates for DaVinci.
Change in v2 is that merge of Ohad's remoteproc branch
has been dropped.

Thanks,
Sekhar

The following changes since commit 93bd65150e4ee783b7366fd0e8172f347515df61:

  ARM: davinci: remove test for undefined Kconfig macro (2013-04-03 09:43:08 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.10/soc-2-v2

for you to fetch changes up to 215a084dc5cb8d814aeb7a2b5192af20aec8209f:

  ARM: davinci: ensure global variables are declared (2013-04-17 19:26:41 +0530)

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
