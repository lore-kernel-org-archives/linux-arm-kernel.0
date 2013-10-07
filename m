From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 07 Oct 2013 16:51:04 +0200
Subject: [GIT PULL] cpuidle ARM: new material for 3.13
Message-ID: <5252CA58.700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Rafael,

this pull request based on 3.12-rc4 contains the following changes:

- Daniel Lezcano converted the zynq cpuidle driver to the platform 
driver and fixed a section mismatch for ux500

- Lorenzo Pieralisi fixed the Makefile format for ARM


Thanks
-- Daniel


The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next

for you to fetch changes up to 2c2b24d9c3e96d5cf974be4559a936e7f3b50225:

ARM: ux500: cpuidle: fix section mismatch (2013-10-07 16:47:07 +0200)

----------------------------------------------------------------
Daniel Lezcano (3):
ARM: zynq: cpuidle: Remove useless compatibility string
ARM: zynq: cpuidle: convert to platform driver
ARM: ux500: cpuidle: fix section mismatch

Lorenzo Pieralisi (1):
drivers: cpuidle: rename ARM big.LITTLE driver config and makefile entries

arch/arm/mach-zynq/common.c | 6 ++++++
drivers/cpuidle/Kconfig.arm | 22 +++++++++++-----------
drivers/cpuidle/Makefile | 2 +-
drivers/cpuidle/cpuidle-ux500.c | 2 +-
drivers/cpuidle/cpuidle-zynq.c | 17 +++++++++++------
5 files changed, 30 insertions(+), 19 deletions(-)



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
