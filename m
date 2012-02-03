From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 03 Feb 2012 15:19:50 +0100
Subject: [GIT PULL] at91: pm cleanup for standby
Message-ID: <4F2BED06.9@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is an AT91 power management cleanup done recently by Daniel Lezcano. This series goes on top of the pull request that I have just sent (at91-3.4-base branch).

Here is the diffstat from the "CAP9 removal" commit that lies in the at91-3.4-base branch.


The following changes since commit 9918ceafd4a9e013572e03983f528017c29bb1cb:

  ARM: at91: code removal of CAP9 SoC (2012-02-03 13:33:05 +0100)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git at91-3.4-base+pm_cleanup

Daniel Lezcano (4):
      ARM: at91: coding style fixes
      ARM: at91: declare header name
      ARM: at91: remove wait_for_interrupt definition
      ARM: at91: implement the standby function for pm/cpuidle

 arch/arm/mach-at91/cpuidle.c |   11 ++----
 arch/arm/mach-at91/pm.c      |   12 +------
 arch/arm/mach-at91/pm.h      |   73 +++++++++++++++++++++++++++---------------
 3 files changed, 51 insertions(+), 45 deletions(-)

Thanks, best regards,
-- 
Nicolas Ferre
