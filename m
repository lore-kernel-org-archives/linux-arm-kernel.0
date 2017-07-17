From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 17 Jul 2017 11:15:38 +0200
Subject: [PATCH v2] ARM: dts: at91: sama5d2_xplained: use pin macros
 instead of numbers
In-Reply-To: <20170710061205.12921-1-ludovic.desroches@microchip.com>
References: <201707090720.uyYcbj17%fengguang.wu@intel.com>
 <20170710061205.12921-1-ludovic.desroches@microchip.com>
Message-ID: <20170717091538.dacforjesplevsa4@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2017 at 08:12:05 +0200, Ludovic Desroches wrote:
> Use pin macros instead of magic numbers to ease interpretation.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
> 
> I have remove the unexpected brace removal from the first version of this patch.
> 
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
