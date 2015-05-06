From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 6 May 2015 17:01:11 -0400 (EDT)
Subject: [GIT PULL] Second round of MCPM refactoring
Message-ID: <alpine.LFD.2.11.1505061643530.7750@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Russell, please pull the following:

	git://git.linaro.org/people/nicolas.pitre/linux mcpm

This is the same MCPM patches I posted last week with review tags added.
Except for the hip04 changes that now have been tested, this is all 
generic changes and your tree should be appropriate for this series.
No new code going in arm-soc should have a dependency on this either.

diffstat:

 arch/arm/common/mcpm_entry.c         | 281 +++++++++++++----------------
 arch/arm/include/asm/mcpm.h          |  73 +++-----
 arch/arm/mach-exynos/suspend.c       |   8 +-
 arch/arm/mach-hisi/platmcpm.c        | 127 +++++--------
 drivers/cpuidle/cpuidle-big_little.c |   8 +-
 5 files changed, 198 insertions(+), 299 deletions(-)

Thanks


Nicolas
