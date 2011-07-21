From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 21 Jul 2011 08:06:09 +0200
Subject: [PATCH 6/7] add macro definitions according to ehci-mxc driver
	change
In-Reply-To: <1311160106-4898-7-git-send-email-tony.lin@freescale.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-7-git-send-email-tony.lin@freescale.com>
Message-ID: <20007.49617.516780.740614@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Tony Lin writes:
> Signed-off-by: Tony Lin <tony.lin@freescale.com>
> ---
>  arch/arm/mach-mxs/include/mach/hardware.h |    2 ++
>  arch/arm/mach-mxs/include/mach/mxs.h      |   12 +++++++++++-
>  arch/arm/plat-mxc/include/mach/mxc.h      |    3 +++
>  3 files changed, 16 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/include/mach/hardware.h b/arch/arm/mach-mxs/include/mach/hardware.h
> index 53e89a0..affa72b 100644
> --- a/arch/arm/mach-mxs/include/mach/hardware.h
> +++ b/arch/arm/mach-mxs/include/mach/hardware.h
> @@ -26,4 +26,6 @@
>  #define IOMEM(addr)	((void __force __iomem *)(addr))
>  #endif
>  
> +#include "mxs.h"
> +
>  #endif /* __MACH_MXS_HARDWARE_H__ */
> diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
> index 35a89dd..6e5928d 100644
> --- a/arch/arm/mach-mxs/include/mach/mxs.h
> +++ b/arch/arm/mach-mxs/include/mach/mxs.h
> @@ -35,7 +35,17 @@
>  		machine_is_mx28evk() ||					\
>  		machine_is_tx28() ||					\
>  		0)
> -
> +#define cpu_is_mx1()		(0)
> +#define cpu_is_mx21()		(0)
> +#define cpu_is_mx25()		(0)
> +#define cpu_is_mx27()		(0)
> +#define cpu_is_mx31()		(0)
> +#define cpu_is_mx35()		(0)
> +#define cpu_is_mx50()		(0)
> +#define cpu_is_mx51()		(0)
> +#define cpu_is_mx53()		(0)
>
No need for parens around bare numbers.



Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
