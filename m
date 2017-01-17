From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 17 Jan 2017 21:02:01 +0100
Subject: [GIT PULL] ARM: at91: soc for 4.11
Message-ID: <20170117200201.iab5vcvmjbfw33nf@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

A single cleanup for mach-at91. Maybe I'll send another pull request
later with further PM cleanup. Else, that will probably be all for 4.11

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.11-soc

for you to fetch changes up to 6cc7fbdf8d931eefa2d0aabf0d2840e94ba09ae5:

  ARM: at91: pm: remove useless extern definition (2017-01-11 13:21:24 +0100)

----------------------------------------------------------------
SoC for 4.11:

 - small cleanup

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: at91: pm: remove useless extern definition

 arch/arm/mach-at91/pm.c | 2 +-
 arch/arm/mach-at91/pm.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
