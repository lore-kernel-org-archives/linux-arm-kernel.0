From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 May 2013 13:27:05 +0100
Subject: [PATCH -v10 10/11] arm, change reboot_mode to use enum reboot_mode
In-Reply-To: <1368273447-11958-11-git-send-email-holt@sgi.com>
References: <1368273447-11958-1-git-send-email-holt@sgi.com>
 <1368273447-11958-11-git-send-email-holt@sgi.com>
Message-ID: <20130511122705.GZ18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 11, 2013 at 06:57:26AM -0500, Robin Holt wrote:
> diff --git a/arch/arm/mach-ixp4xx/include/mach/timex.h b/arch/arm/mach-ixp4xx/include/mach/timex.h
> index c9e930f..729b2db 100644
> --- a/arch/arm/mach-ixp4xx/include/mach/timex.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/timex.h
> @@ -3,7 +3,7 @@
>   * 
>   */
>  
> -#include <mach/hardware.h>
> +// #include <mach/hardware.h>
>  
>  /*
>   * We use IXP425 General purpose timer for our timer needs, it runs at 

Apart from this, everything else here looks fine from a quick scan.
If the above is needed to fix some build error, it should be a separate
patch sent to the arm-soc people.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.
