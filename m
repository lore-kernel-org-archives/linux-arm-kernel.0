From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 14 Mar 2012 23:50:13 +0100
Subject: [GIT PULL] ARM: OMAP: i2c, gpio, spi and regulator DTS updates
In-Reply-To: <4F5E89B4.4010505@ti.com>
References: <4F5E89B4.4010505@ti.com>
Message-ID: <4F6120A5.6050407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

It looks like Chris Ball just queued  the HSMMC DT stuff from Rajendra, 
so I can add as well the MMC DTS for OMAP3 and OMAP4 as well.

It is fine for an update?

Than I can add as Kevin's patch for twl irq_base removal.

Thanks,
Benoit

On 3/13/2012 12:41 AM, Cousson, Benoit wrote:
> Hi Tony,
>
> Here are the remaining DTS patches for 3.4.
>
> Ideally all the driver DT adaptation should have been merged before that one.
>
> This series is based on your lo/dt-part2 branch.
>
> Thanks,
> Benoit
>
>
> The following changes since commit 328ae2cb50af2f96b6061eb462aa92966a462bbc:
>    Ilya Yanok (1):
>          arm/dts: mt_ventoux: very basic support for TeeJet Mt.Ventoux board
>
> are available in the git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dts/all
>
> Benoit Cousson (11):
>        arm/dts: twl6030: Add DTS file for twl6030 PMIC
>        arm/dts: twl4030: Add DTS file for twl4030 PM + Audio IC
>        arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
>        arm/dts: omap4-sdp: Add twl6030, i2c3 and i2c4 devices
>        arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
>        ARM: OMAP2+: board-generic: Remove i2c static init
>        arm/dts: OMAP4: Add gpio nodes
>        arm/dts: OMAP3: Add gpio nodes
>        arm/dts: OMAP4: Add SPI controller nodes
>        arm/dts: OMAP3: Add SPI controller nodes
>        arm/dts: omap4-sdp: Add ks8851 ethernet SPI device
>
> Rajendra Nayak (1):
>        arm/dts: twl: Pass regulator data from dt
>
>   arch/arm/boot/dts/omap3-beagle.dts  |   35 ++++++++++++++
>   arch/arm/boot/dts/omap3.dtsi        |   86 +++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/omap4-panda.dts   |   34 ++++++++++++++
>   arch/arm/boot/dts/omap4-sdp.dts     |   73 +++++++++++++++++++++++++++++
>   arch/arm/boot/dts/omap4.dtsi        |   86 +++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/twl4030.dtsi      |   39 ++++++++++++++++
>   arch/arm/boot/dts/twl6030.dtsi      |   86 +++++++++++++++++++++++++++++++++++
>   arch/arm/mach-omap2/board-generic.c |   37 +--------------
>   arch/arm/mach-omap2/devices.c       |    4 +-
>   arch/arm/mach-omap2/gpio.c          |    8 +++-
>   10 files changed, 450 insertions(+), 38 deletions(-)
>   create mode 100644 arch/arm/boot/dts/twl4030.dtsi
>   create mode 100644 arch/arm/boot/dts/twl6030.dtsi
>
