From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 24 Oct 2013 15:01:20 +0800
Subject: [PATCHv4 2/2] ARM: dts: Add support for the cpuimx51 board from
 Eukrea and its baseboard.
In-Reply-To: <1382519393-17055-2-git-send-email-denis@eukrea.com>
References: <1382519393-17055-1-git-send-email-denis@eukrea.com>
 <1382519393-17055-2-git-send-email-denis@eukrea.com>
Message-ID: <20131024070116.GE11466@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 11:09:53AM +0200, Denis Carikli wrote:
> The following devices/functionalities were added:
>  * Main and secondary UARTs.
>  * i2c and the pcf8563 device.
>  * Ethernet.
>  * NAND.
>  * The BP1 button.
>  * The LED.
>  * Watchdog
>  * SD.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi       |   63 ++++++++++
>  .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |  132 ++++++++++++++++++++
>  2 files changed, 195 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
>  create mode 100644 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts

Applied both patches, after adding imx51-eukrea-mbimxsd51-baseboard.dtb
target into arch/arm/boot/dts/Makefile.

Shawn
