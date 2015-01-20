From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 20 Jan 2015 20:35:25 +0530
Subject: [GIT PULL] DaVinci cleanups for v3.20
In-Reply-To: <1421766325-28293-1-git-send-email-nsekhar@ti.com>
References: <1421766325-28293-1-git-send-email-nsekhar@ti.com>
Message-ID: <1421766325-28293-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.20/cleanup

for you to fetch changes up to 65010564d698ef99b24b04a16e7bcabcd6171c64:

  ARM: davinci: Remove CDCE949 driver (2015-01-20 19:29:58 +0530)

----------------------------------------------------------------
Removes an unused function and the unused
support for CDCE949 clock generator.

----------------------------------------------------------------
Rickard Strandqvist (2):
      ARM: davinci: serial.c: remove unused serial_read_reg()
      ARM: davinci: Remove CDCE949 driver

 arch/arm/mach-davinci/Makefile               |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c     |   31 ---
 arch/arm/mach-davinci/cdce949.c              |  295 --------------------------
 arch/arm/mach-davinci/include/mach/cdce949.h |   19 --
 arch/arm/mach-davinci/serial.c               |   10 -
 5 files changed, 1 insertion(+), 356 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/cdce949.c
 delete mode 100644 arch/arm/mach-davinci/include/mach/cdce949.h
