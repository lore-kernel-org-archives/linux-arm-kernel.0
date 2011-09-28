From: nicolas.ferre@atmel.com (Nicolas FERRE)
Date: Wed, 28 Sep 2011 23:19:51 +0200
Subject: [GIT PULL] at91 fixes for 3.1
Message-ID: <4E838F77.2040705@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Here is a couple of fixes that may be included in 3.1-final.
The Kconfig modification will allow to select the PWM driver for SAM9G45 
SoC. This will also benefit to stable kernels.
The new defconfig for SAM9G45 family will allow us to better monitor the 
health of this port through automatic compilation mechanism. I find it 
interesting to have it included the sooner.

The pull is based on the following changes since commit 
a102a9ece5489e1718cd7543aa079082450ac3a2:

   Linux 3.1-rc8 (2011-09-27 15:48:34 -0700)

are available in the git repository at:
   git://github.com/at91linux/linux-at91.git at91-fixes

Nicolas Ferre (2):
   ARM: at91: remove dependency for Atmel PWM driver selector in Kconfig
   ARM: at91: add defconfig for at91sam9g45 family

  arch/arm/configs/at91sam9g45_defconfig |  214 ++++++++++++++++++++++
  drivers/misc/Kconfig                   |    1 -
  2 files changed, 214 insertions(+), 1 deletions(-)
  create mode 100644 arch/arm/configs/at91sam9g45_defconfig

-- 
Nicolas Ferre
