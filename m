From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 18 Mar 2014 10:33:54 +0800
Subject: [PATCH 0/3] ARM: at91: add enter standby mode for ARMv7
Message-ID: <1395110037-23151-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

The patches is to add support to enter standby mode for ARMv7,
then enabling the feature to disable main oscillator
when suspending to memory for sama5d3x.

The patches is based on branch, for-next and at91/cleanup
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git

Best Regards,
Wenyou Yang

Wenyou Yang (3):
  ARM: at91: pm: add the socs support the DDRC controller
  ARM: at91: pm_slowclock: add enter standby mode for ARMv7
  defconfig: arm: sama5_defconfig: update

 arch/arm/configs/sama5_defconfig  |    1 +
 arch/arm/mach-at91/pm.c           |    5 ++++-
 arch/arm/mach-at91/pm_slowclock.S |   16 +++++++++++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

-- 
1.7.9.5
