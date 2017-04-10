From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Apr 2017 12:28:42 +0200
Subject: [PATCH 2/2] ARM: dts: at91: sama5d3_xplained: not all ADC
 channels are available
In-Reply-To: <20170410082517.19628-2-ludovic.desroches@microchip.com>
References: <20170410082517.19628-1-ludovic.desroches@microchip.com>
 <20170410082517.19628-2-ludovic.desroches@microchip.com>
Message-ID: <20170410102842.3r6as5jqusby7wvu@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2017 at 10:25:17 +0200, Ludovic Desroches wrote:
> Remove ADC channels that are not available by default on the sama5d3_xplained
> board (resistor not populated) in order to not create confusion.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: <stable@vger.kernel.org> # 3.16+
> ---
>  arch/arm/boot/dts/at91-sama5d3_xplained.dts | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
