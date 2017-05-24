From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 24 May 2017 11:44:53 +0530
Subject: [GIT PULL] DaVinci fixes for v4.12
Message-ID: <ded91b7c-fcd0-0891-23ac-18d9b9e4ea39@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.12

for you to fetch changes up to 95d7c1f18bf8ac03b0fc48eac1f1b11f867765b8:

  ARM: davinci: PM: Do not free useful resources in normal path in 'davinci_pm_init' (2017-05-17 15:25:18 +0530)

----------------------------------------------------------------
These fix issues with power management initialization code
on DaVinci. Some resources were getting freed prematurely.
And there was an issue with resources not being on error.

----------------------------------------------------------------
Christophe JAILLET (2):
      ARM: davinci: PM: Free resources in error handling path in 'davinci_pm_init'
      ARM: davinci: PM: Do not free useful resources in normal path in 'davinci_pm_init'

 arch/arm/mach-davinci/pm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
