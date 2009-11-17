From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 17 Nov 2009 11:56:38 -0500
Subject: [PATCH] ep93xx: add missing newline between file header and code
In-Reply-To: <200911171245.56363.h.feurstein@gmail.com>
References: <200911171245.56363.h.feurstein@gmail.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901EE5529@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 17, 2009 4:46 AM, Hubert Feurstein wrote:
>
> Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
> ---
>  Just for the sake of consistency across the ep93xx-tree.
> 
>  arch/arm/mach-ep93xx/include/mach/hardware.h |    1 +
>  arch/arm/mach-ep93xx/include/mach/io.h       |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/hardware.h b/arch/arm/mach-ep93xx/include/mach/hardware.h
> index 349fa7c..5a3ce02 100644
> --- a/arch/arm/mach-ep93xx/include/mach/hardware.h
> +++ b/arch/arm/mach-ep93xx/include/mach/hardware.h
> @@ -1,6 +1,7 @@
>  /*
>   * arch/arm/mach-ep93xx/include/mach/hardware.h
>   */
> +
>  #ifndef __ASM_ARCH_HARDWARE_H
>  #define __ASM_ARCH_HARDWARE_H
>  
> diff --git a/arch/arm/mach-ep93xx/include/mach/io.h b/arch/arm/mach-ep93xx/include/mach/io.h
> index cebcc1c..594b77f 100644
> --- a/arch/arm/mach-ep93xx/include/mach/io.h
> +++ b/arch/arm/mach-ep93xx/include/mach/io.h
> @@ -1,6 +1,7 @@
>  /*
>   * arch/arm/mach-ep93xx/include/mach/io.h
>   */
> +
>  #ifndef __ASM_MACH_IO_H
>  #define __ASM_MACH_IO_H

Nitpick janitor patch but..

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
