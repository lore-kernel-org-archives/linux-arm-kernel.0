From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Dec 2013 11:52:52 +0800
Subject: [PATCHv13] ARM: dts: Add support for the cpuimx25 board from
 Eukrea and its baseboard.
In-Reply-To: <1386255416-18661-1-git-send-email-denis@eukrea.com>
References: <1386255416-18661-1-git-send-email-denis@eukrea.com>
Message-ID: <20131209035250.GE825@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 03:56:56PM +0100, Denis Carikli wrote:
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
> ChangeLog v10->v13:
> - The display part was splitted out because it depends on other
>   patches that are not applied yet, the commit message was updated accordingly.
> - The new GPIO and input defines are now used in the dts(i).
> 
> ChangeLog v9->v10:
> - Adapted to the new pingrp patches.
> 
> ChangeLog v8->v9:
> - Licenses were shortened.
> ---
>  arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |   60 ++++++++++
>  .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |  119 ++++++++++++++++++++
>  2 files changed, 179 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
>  create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts

Added the dtb target into arch/arm/boot/dts/Makefile, and applied the
patch.

Shawn
