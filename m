From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 Jan 2018 23:21:45 +0100
Subject: [PATCH] ARM: dts: at91: sama5d4: fix pinctrl compatible string
In-Reply-To: <20180118143847.15309-1-ludovic.desroches@microchip.com>
References: <20180118143847.15309-1-ludovic.desroches@microchip.com>
Message-ID: <20180130222145.GO2809@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/2018 at 15:38:47 +0100, Ludovic Desroches wrote:
> From: Santiago Esteban <Santiago.Esteban@microchip.com>
> 
> The compatible string is incorrect. Add atmel,sama5d3-pinctrl since
> it's the appropriate compatible string. Remove the
> atmel,at91rm9200-pinctrl compatible string, this fallback is
> useless, there are too many changes.
> 
> Signed-off-by: Santiago Esteban <Santiago.Esteban@microchip.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: stable at vger.kernel.org #v3.18
> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
