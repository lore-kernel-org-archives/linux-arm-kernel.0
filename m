From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 21 Mar 2018 17:23:09 +0100
Subject: [PATCH] ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property
In-Reply-To: <20180313152005.21132-1-nicolas.ferre@microchip.com>
References: <20180313152005.21132-1-nicolas.ferre@microchip.com>
Message-ID: <20180321162309.GI3417@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/2018 at 16:20:05 +0100, Nicolas Ferre wrote:
> There are only 19 PIOB pins having primary names PB0-PB18. Not all of them
> have a 'C' function. So the pinctrl property mask ends up being the same as the
> other SoC of the at91sam9x5 series.
> 
> Reported-by: Marek Sieranski <marek.sieranski@microchip.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: <stable@vger.kernel.org> # v3.8+
> ---
>  arch/arm/boot/dts/at91sam9g25.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
