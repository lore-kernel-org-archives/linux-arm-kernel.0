From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 10 Oct 2011 11:46:17 +0200
Subject: [GIT PULL] at91: driver for Atmel true hardware random number
	generator
Message-ID: <4E92BEE9.5090604@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Here is a couple of patches for adding the True Random Number Generator
that can be find on some AT91SAM SoCs.
Herbert Xu told me that this material can go through the ARM SoC tree.

They may conflict with future work on at91 gpio that can be found on at91-next 
branch. We will recall you this during the "pull request" that we will send you 
for those bits...

The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:

  Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)

are available in the git repository at:
git://github.com/at91linux/linux-at91.git for-arnd/at91-trng

Peter Korsgaard (2):
      ARM: at91: at91sam9g45: add trng clock and platform device
      hw_random: add driver for atmel true hardware random number generator

 arch/arm/mach-at91/at91sam9g45.c         |    7 ++
 arch/arm/mach-at91/at91sam9g45_devices.c |   29 ++++++
 drivers/char/hw_random/Kconfig           |   13 +++
 drivers/char/hw_random/Makefile          |    1 +
 drivers/char/hw_random/atmel-rng.c       |  158 ++++++++++++++++++++++++++++++
 5 files changed, 208 insertions(+), 0 deletions(-)
 create mode 100644 drivers/char/hw_random/atmel-rng.c

Thanks, cheers,
-- 
Nicolas Ferre
