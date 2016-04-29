From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 29 Apr 2016 14:55:02 +0530
Subject: [GIT PULL] DaVinci fixes for v4.6
Message-ID: <5723286E.7050601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for sending this late, but I was waiting to see if
Greg would rather send this (because the issue came
through patches he merged). I have not received a response
and there is danger of missing v4.6 altogether if we wait
any further.

So here it is. Its based on latest in Linus's tree.

Regards,
Sekhar

The following changes since commit 92c19ea9535707701861b7533253a516c7d115c9:

  Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2016-04-28 20:24:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.6

for you to fetch changes up to 29b933b6d84219af8456dee172ddc6d676ebbcd3:

  ARM: davinci: only use NVMEM when available (2016-04-29 14:21:14 +0530)

----------------------------------------------------------------
This patch fixes build breakage when
nvmem framework is built as module.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: davinci: only use NVMEM when available

 arch/arm/mach-davinci/board-mityomapl138.c | 5 +++++
 arch/arm/mach-davinci/common.c             | 5 +++++
 2 files changed, 10 insertions(+)
