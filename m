From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Nov 2014 21:13:01 +0530
Subject: [GIT PULL] DaVinci updates for v3.19 - cleanups
In-Reply-To: <1416498181-15988-1-git-send-email-nsekhar@ti.com>
References: <1416498181-15988-1-git-send-email-nsekhar@ti.com>
Message-ID: <1416498181-15988-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.19/cleanup

for you to fetch changes up to 14f6aeb4e5da6b37bef6a70346260a69bd6b42d0:

  ARM: davinci: Remove redundant casts (2014-11-18 21:11:13 +0530)

----------------------------------------------------------------
Fix some non-standard logging styles and remove
some unnecessary typecasting.

----------------------------------------------------------------
Joe Perches (1):
      ARM: davinci: Use standard logging styles

Rasmus Villemoes (1):
      ARM: davinci: Remove redundant casts

 arch/arm/mach-davinci/board-da830-evm.c    |   89 ++++++++++++----------------
 arch/arm/mach-davinci/board-da850-evm.c    |    9 +--
 arch/arm/mach-davinci/board-dm644x-evm.c   |   10 ++--
 arch/arm/mach-davinci/board-mityomapl138.c |   45 +++++++-------
 arch/arm/mach-davinci/board-neuros-osd2.c  |    5 +-
 arch/arm/mach-davinci/clock.c              |    2 +-
 arch/arm/mach-davinci/mux.c                |   15 +++--
 arch/arm/mach-davinci/time.c               |   13 ++--
 8 files changed, 84 insertions(+), 104 deletions(-)
