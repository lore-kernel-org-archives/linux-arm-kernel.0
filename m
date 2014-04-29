From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 29 Apr 2014 11:15:38 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v3.16
Message-ID: <cover.1398737681.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC updates for v3.16.

This pull request is based on the previous round of
such requests, tagged as renesas-soc-for-v3.16,
which I have already sent a pull-request for.


The following changes since commit e35db38d66d1e4007cfc1bb90a05e11b4aaee2a8:

  ARM: shmobile: r8a7778/bockw: Move "select RENESAS_INTC_IRQPIN" under SoC (2014-04-14 11:28:43 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.16

for you to fetch changes up to ab496b9d259e754f5d646219e4f032b274b9fffe:

  ARM: shmobile: Ignore callbacks for subsys generic_pm_domain_data (2014-04-25 10:01:43 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Updates for v3.16

Power management code which is only used by
sh7372 (SH-Mobile AP4) based Mackerl board
* Ignore callbacks for subsys generic_pm_domain_data

----------------------------------------------------------------
Ulf Hansson (1):
      ARM: shmobile: Ignore callbacks for subsys generic_pm_domain_data

 arch/arm/mach-shmobile/pm-rmobile.c | 38 +++----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)
