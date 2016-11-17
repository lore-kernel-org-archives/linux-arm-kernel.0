From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 17 Nov 2016 22:49:00 +0100
Subject: [GIT PULL] ARM: mvebu: drivers for v4.10 (#1)
Message-ID: <87r369bwvn.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for drivers for mvebu for v4.10.

Gregory

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-4.10-1

for you to fetch changes up to d6ea689345ecc27b636a8bb62bf07080f21f110c:

  ARM/orion/gpio: Replace three seq_printf() calls by seq_puts() in orion_gpio_dbg_show() (2016-10-17 17:40:24 +0200)

----------------------------------------------------------------
mvebu drivers for 4.10 (part 1)

Clean-up on thegpio driver for old SoCs(non DT)

----------------------------------------------------------------
Markus Elfring (1):
      ARM/orion/gpio: Replace three seq_printf() calls by seq_puts() in orion_gpio_dbg_show()

 arch/arm/plat-orion/gpio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
