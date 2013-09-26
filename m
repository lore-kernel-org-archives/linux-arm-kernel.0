From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 26 Sep 2013 10:44:56 +0100
Subject: [GIT PULL] ARM/ARM64 architected timer updates for v3.13
Message-ID: <52440218.9040009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Please pull the ARM/ARM64 arch timer updates for v3.13.

Regards,
Sudeep

-->8--

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

  Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:

  git://linux-arm.org/linux-skn.git timer_evtstrm

for you to fetch changes up to 346e7480f1d4740b3d798da60f83f087ea6488b4:

  drivers: clocksource: add CPU PM notifier for ARM architected timer
(2013-09-26 09:48:24 +0100)

----------------------------------------------------------------
Sudeep KarkadaNagesha (4):
      ARM/ARM64: arch_timer: add macros for bits in control register
      ARM: arch_timer: add support to configure and enable event stream
      ARM64: arch_timer: add support to configure and enable event stream
      drivers: clocksource: add CPU PM notifier for ARM architected timer

Will Deacon (1):
      drivers: clocksource: add support for ARM architected timer event stream

 arch/arm/include/asm/arch_timer.h    | 36 +++++++++++++++++++++++-----
 arch/arm/include/uapi/asm/hwcap.h    |  1 +
 arch/arm/kernel/setup.c              |  1 +
 arch/arm64/include/asm/arch_timer.h  | 42 +++++++++++++++++++++++++++------
 arch/arm64/include/asm/hwcap.h       | 11 +++----
 arch/arm64/include/uapi/asm/hwcap.h  |  1 +
 arch/arm64/kernel/setup.c            | 11 +++++++
 drivers/clocksource/Kconfig          | 15 ++++++++++++
 drivers/clocksource/arm_arch_timer.c | 49 ++++++++++++++++++++++++++++++++++++
 include/clocksource/arm_arch_timer.h | 10 ++++++++++
 10 files changed, 161 insertions(+), 16 deletions(-)
