From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 2 Oct 2018 14:36:26 +0200
Subject: [PATCH 1/2] ARM: dts: at91: sama5d4_xplained: fix addresable
 nand flash size
In-Reply-To: <20181002112949.22961-1-tudor.ambarus@microchip.com>
References: <20181002112949.22961-1-tudor.ambarus@microchip.com>
Message-ID: <20181002123626.GC4088@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tudor,

There is a typo is your subject line.I don't have any other comment ;)

On 02/10/2018 14:29:48+0300, Tudor Ambarus wrote:
> sama5d4_xplained comes with a 4Gb NAND flash. Increase the rootfs
> size to match this limit.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d4_xplained.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> index 4b7c762d5f22..7d554b9ab27f 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -252,7 +252,7 @@
>  
>  						rootfs at 800000 {
>  							label = "rootfs";
> -							reg = <0x800000 0x0f800000>;
> +							reg = <0x800000 0x1f800000>;
>  						};
>  					};
>  				};
> -- 
> 2.9.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
