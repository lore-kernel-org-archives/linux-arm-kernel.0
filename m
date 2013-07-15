From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 16 Jul 2013 01:28:25 +0200
Subject: pull request for cpuidle/arm
Message-ID: <51E48599.8000104@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 68ba7add2f6e216227c3a3d225316987624b71c8:

Merge branch 'pm-cpufreq-next' into linux-next (2013-07-15 14:12:32 +0200)

are available in the git repository at:


git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next

for you to fetch changes up to 6a814a059092c3934d13c19c34123827d0e1dc95:

ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle
(2013-07-16 00:55:05 +0200)

----------------------------------------------------------------
Daniel Lezcano (2):
ARM: davinci: cpuidle: Fix target residency
ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle

Linus Walleij (2):
ARM: ux500: cpuidle: Instantiate the driver from platform device
ARM: ux500: cpuidle: Remove pointless include

arch/arm/mach-davinci/cpuidle.c | 2 +-
arch/arm/mach-ux500/Makefile | 1 -
drivers/cpuidle/Kconfig.arm | 8 ++++++++
drivers/cpuidle/Makefile | 1 +
.../cpuidle.c => drivers/cpuidle/cpuidle-ux500.c | 19 +++++++++++--------
drivers/mfd/db8500-prcmu.c | 4 ++++
6 files changed, 25 insertions(+), 10 deletions(-)
rename arch/arm/mach-ux500/cpuidle.c => drivers/cpuidle/cpuidle-ux500.c
(90%)

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
