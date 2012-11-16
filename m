From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 16 Nov 2012 16:35:17 +0100
Subject: [GIT PULL] at91: fixes for 3.7-rc6
Message-ID: <50A65D35.7090307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Resent with mailing-lists)

Arnd, Olof,

Here is the second at91-fixes pull request for 3.7. I have built it on
top of my previous fixes pull request for this kernel revision.

The following changes since commit 08d04a135a1c2e24c4d4bc7bbafee5e0e58f80c6:

  ARM: at91: drop duplicated config SOC_AT91SAM9 entry (2012-10-24
18:08:48 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to 641f3ce64b050961d454a0716bb6dbf528315aac:

  ARM: at91/usbh: fix overcurrent gpio setup (2012-11-16 10:46:29 +0100)

----------------------------------------------------------------
Two little fixes, one related to the move to sparse irq and
another one fixing the check of a GPIO for USB host overcurrent.

----------------------------------------------------------------
Johan Hovold (1):
      ARM: at91/usbh: fix overcurrent gpio setup

Nicolas Royer (1):
      ARM: at91/AT91SAM9G45: fix crypto peripherals irq issue due to
sparse irq support

 arch/arm/mach-at91/at91rm9200_devices.c  |  2 +-
 arch/arm/mach-at91/at91sam9260_devices.c |  2 +-
 arch/arm/mach-at91/at91sam9261_devices.c |  2 +-
 arch/arm/mach-at91/at91sam9263_devices.c |  2 +-
 arch/arm/mach-at91/at91sam9g45_devices.c | 12 ++++++------
 5 files changed, 10 insertions(+), 10 deletions(-)

Thanks, best regards,
-- 
Nicolas Ferre
