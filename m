From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Wed, 11 Nov 2015 19:32:17 +0200
Subject: [PATCH 0/6] ARM: OMAP2+: dts: cm-t335: initial support
In-Reply-To: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <56437BA1.8030807@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gentle ping

On 27/10/15 14:14, Uri Mashiach wrote:
> Add basic support for CompuLab cm-t335 module based on AM335X SoC.
>
> CM-T335 is a tiny computer-on-module (CoM) / system-on-module (SoM)
> The module is built around the Texas Instruments Sitara AM3352/4
> system-on-chip.
>
> The CPU is supplemented with up-to 512MB DDR3 and up-to 1GB of on-board
> NAND storage, WiFi connected to SPI, Bluetooth, Analog audio, Gigabit
> Ethernet, CAN bus.
>
> Ilya Ledvich (6):
>    ARM: OMAP2+: dts: cm-t335: add initial support
>    ARM: OMAP2+: dts: cm-t335: add basic support for I2C
>    ARM: OMAP2+: dts: cm-t335: add support for NAND flash
>    ARM: OMAP2+: dts: cm-t335: add support for MMC
>    ARM: OMAP2+: dts: cm-t335: add support for network device
>    ARM: OMAP2+: dts: cm-t335: add support for PWM backlight
>
>   .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>   arch/arm/boot/dts/Makefile                         |   7 +-
>   arch/arm/boot/dts/am335x-cm-t335.dts               | 347 +++++++++++++++++++++
>   3 files changed, 354 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm/boot/dts/am335x-cm-t335.dts
>
