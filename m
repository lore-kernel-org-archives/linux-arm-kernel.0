From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 9 Feb 2013 23:28:40 +0530
Subject: [GIT PULL] DaVinci DT updates for v3.9 (part 2)
Message-ID: <51168E50.1010709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following changes for v3.9?

Thanks,
Sekhar

The following changes since commit 1661636d362b6d1a6c2bab210f2ab363a69deccc:

  ARM: davinci: da850: add RTC DT entries (2013-01-28 21:28:11 +0530)

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git tags/davinci-for-v3.9/dt-2

for you to fetch changes up to 19c7c0d81a9b1fe7342d0208b629b5e085e4f3ae:

  ARM: davinci: da850 DT: add support for machine reboot (2013-02-09 22:38:26 +0530)

----------------------------------------------------------------
Second round of DT updates for DaVinci.

This pull request adds support for I2C0 and watchdog timer
for DA850 EVM booting using device tree. It also enables
machine reboot when using device tree.

----------------------------------------------------------------
Kumar, Anil (2):
      ARM: davinci: da850: add wdt DT node
      ARM: davinci: da850 DT: add support for machine reboot

Vishwanathrao Badarkhe, Manish (1):
      ARM: davinci: da850: add DT node for I2C0

 arch/arm/boot/dts/da850-evm.dts            |    9 +++++++++
 arch/arm/boot/dts/da850.dtsi               |   19 +++++++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c           |    9 ++++++++-
 arch/arm/mach-davinci/devices-da8xx.c      |   12 ++++++++++--
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 -
 5 files changed, 46 insertions(+), 4 deletions(-)
