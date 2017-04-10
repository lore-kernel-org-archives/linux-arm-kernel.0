From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Apr 2017 12:28:27 +0200
Subject: [PATCH 1/2] ARM: dts: at91: sama5d3_xplained: fix ADC vref
In-Reply-To: <20170410082517.19628-1-ludovic.desroches@microchip.com>
References: <20170410082517.19628-1-ludovic.desroches@microchip.com>
Message-ID: <20170410102827.fo3lvmlmrfsbmjxj@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2017 at 10:25:16 +0200, Ludovic Desroches wrote:
> The voltage reference for the ADC is not 3V but 3.3V since it is connected to
> VDDANA.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: <stable@vger.kernel.org> # 3.16+
> ---
>  arch/arm/boot/dts/at91-sama5d3_xplained.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
