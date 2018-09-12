From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 12 Sep 2018 12:38:56 +0200
Subject: [PATCH] ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl
In-Reply-To: <20180907081851.15911-1-ludovic.desroches@microchip.com>
References: <20180907081851.15911-1-ludovic.desroches@microchip.com>
Message-ID: <20180912103856.GA2760@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2018 10:18:51+0200, Ludovic Desroches wrote:
> The drive strength has to be set to medium otherwise some data
> corruption may happen.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
> 
> Hi,
> 
> This fix depends on the support of the drive-strength for the atmel pio4
> pinctroller. It has been added in v4.19 but I omitted to send it at the
> same time.
> 
> Ludovic
> 
>  arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
