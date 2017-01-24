From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 24 Jan 2017 18:36:39 +0530
Subject: [GIT PULL 2/4] TI DaVinci SoC support updates for v4.11
In-Reply-To: <20170124130641.28264-1-nsekhar@ti.com>
References: <20170124130641.28264-1-nsekhar@ti.com>
Message-ID: <20170124130641.28264-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.11/soc

for you to fetch changes up to 9c9b1bc25291e275b04f758f2549c81e092954f5:

  ARM: davinci: add skeleton for pdata-quirks (2017-01-23 20:52:38 +0530)

----------------------------------------------------------------
Introduce pdata-quirks mechanism for
DaVinci which will be needed for supporting
video input/output on DA850 SoC.

----------------------------------------------------------------
Kevin Hilman (1):
      ARM: davinci: add skeleton for pdata-quirks

 arch/arm/mach-davinci/Makefile              |  2 +-
 arch/arm/mach-davinci/da8xx-dt.c            |  1 +
 arch/arm/mach-davinci/include/mach/common.h |  2 ++
 arch/arm/mach-davinci/pdata-quirks.c        | 39 +++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-davinci/pdata-quirks.c
