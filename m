From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 13 Sep 2018 15:20:20 -0700
Subject: [PATCH] ARM: dts: brcm: Fix SPI bus warnings
In-Reply-To: <20180913181245.25484-6-robh@kernel.org>
References: <20180913181245.25484-6-robh@kernel.org>
Message-ID: <78e6100f-1932-108a-b3ec-7bb37765583b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/13/18 11:12, Rob Herring wrote:
> dtc has new checks for SPI buses. Fix the warnings in node names.
> 
> arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dtb: Warning (spi_bus_bridge): /axi at 18000000/qspi at 27200: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/bcm958525er.dtb: Warning (spi_bus_bridge): /axi/qspi at 27200: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/bcm958525xmc.dtb: Warning (spi_bus_bridge): /axi/qspi at 27200: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/bcm958622hr.dtb: Warning (spi_bus_bridge): /axi/qspi at 27200: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/bcm958625hr.dtb: Warning (spi_bus_bridge): /axi/qspi at 27200: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/bcm988312hr.dtb: Warning (spi_bus_bridge): /axi/qspi at 27200: node name for SPI buses should be 'spi'
> 
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Jon Mason <jonmason@broadcom.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to devicetree/next, thanks Rob!

NB: s/brcm/bcm/ to be somewhat consistent with file names and past
submissions.
-- 
Florian
