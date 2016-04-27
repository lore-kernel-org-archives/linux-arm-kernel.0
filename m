From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 27 Apr 2016 14:51:46 +0200
Subject: [GIT PULL] at91: defconfig for 4.7 #1
Message-ID: <1461761506-31506-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here is a batch of defconfig update for both AT91 and the multi_v7_defconfig.

Thanks, best regards,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-defconfig

for you to fetch changes up to ed87957b18f238516e578e5dbd44a5db11300831:

  ARM: multi_v7_defconfig: add the Atmel sama5d2-compatible ADC driver (2016-04-27 14:07:59 +0200)

----------------------------------------------------------------
First batch of defconfig updates for 4.7:
- HDMA, HLCD and PDMIC drivers for sama5_defconfig
- several missing drivers in multi_v7_defconfig. In module when possible

----------------------------------------------------------------
Boris Brezillon (1):
      ARM: multi_v7_defconfig: add HLCDC drivers as modules

Nicolas Ferre (7):
      ARM: at91/defconfig: add the HDMA controller to sama5_defconfig
      ARM: at91/defconfig: add HLCDC driver to sama5_defconfig
      ARM: at91/defconfig: add PDMIC driver to sama5_defconfig
      ARM: multi_v7_defconfig: add Atmel watchdog timers
      ARM: multi_v7_defconfig: add Atmel ISI (Image Sensor Interface) driver
      ARM: multi_v7_defconfig: add the Atmel Audio microphone interface PDMIC
      ARM: multi_v7_defconfig: add the Atmel sama5d2-compatible ADC driver

 arch/arm/configs/multi_v7_defconfig |  8 ++++++++
 arch/arm/configs/sama5_defconfig    | 11 +++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
Nicolas Ferre
