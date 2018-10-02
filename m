From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Tue, 2 Oct 2018 13:55:18 +0200
Subject: [PATCH 1/2] ARM: dts: at91: sama5d4_xplained: fix addresable
 nand flash size
In-Reply-To: <20181002112949.22961-1-tudor.ambarus@microchip.com>
References: <20181002112949.22961-1-tudor.ambarus@microchip.com>
Message-ID: <20181002115518.fhj4y2i4zqdrantl@M43218.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2018 at 02:29:48PM +0300, Tudor Ambarus wrote:
> sama5d4_xplained comes with a 4Gb NAND flash. Increase the rootfs
> size to match this limit.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks
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
