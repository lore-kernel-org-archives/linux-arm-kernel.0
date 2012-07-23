From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Jul 2012 20:33:22 -0000
Subject: [GIT PULL 13/15] arm-soc: pincontrol drivers
In-Reply-To: <1343075561-17446-1-git-send-email-arnd@arndb.de>
References: <1343075561-17446-1-git-send-email-arnd@arndb.de>
Message-ID: <1343075561-17446-14-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ca24a145573124732152daff105ba68cc9a2b545:

  Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm (2012-07-01 11:02:25 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git next/pinctrl

for you to fetch changes up to 8ee41a62a3800b8450985d2970fd985421ad7043:

  Merge branch 'prima2/pinctrl' into next/pinctrl (2012-07-04 16:54:54 +0200)

----------------------------------------------------------------

arm-soc: pincontrol drivers

We are converting platforms to use the pinctrl framework over time,
rather than using platform specific code for the same effect. This
adds the respective driver for the prima2 platform.

----------------------------------------------------------------

Arnd Bergmann (4):
      Merge branch 'prima2/drivers' of git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel into next/pinctrl
      ARM: prima2: enable gpiolib unconditionally
      Merge branch 'prima2/pinctrl' into next/pinctrl
      Merge branch 'next/pinctrl' into for-next

Barry Song (1):
      PINCTRL: SiRF: add GPIO and GPIO irq support in CSR SiRFprimaII

 arch/arm/Kconfig                         |    1 +
 arch/arm/mach-prima2/include/mach/gpio.h |   13 +
 arch/arm/mach-prima2/include/mach/irqs.h |    2 +-
 drivers/pinctrl/pinctrl-sirf.c           |  489 +++++++++++++++++++++++++++++-
 4 files changed, 503 insertions(+), 2 deletions(-)
