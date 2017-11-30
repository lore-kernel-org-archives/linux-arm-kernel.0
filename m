From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Thu, 30 Nov 2017 17:23:02 +0000
Subject: [PATCH v3 5/6] ARM: ep93xx: ts72xx: cosmetic: Add some
 description to ts72xx code
In-Reply-To: <20171130004510.23887-6-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130004510.23887-1-lukma@denx.de> <20171130004510.23887-6-lukma@denx.de>
Message-ID: <BLUPR0101MB155444953DA2E47B0AEE80BFD0380@BLUPR0101MB1554.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 29, 2017 5:45 PM, Lukasz Majewski wrote:
> This patch extends readability of ts72xx.c code.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - New patch
> ---
>  arch/arm/mach-ep93xx/ts72xx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

This patch does not apply to linux-next.

> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c index a6e473b3dcf6..2e8fcc6e87b6 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -28,6 +28,9 @@
>  #include "soc.h"
>  #include "ts72xx.h"
>  
> +/**********************************************************************
> +***
> + * IO map
> + 
> +***********************************************************************
> +**/

There is also something funny with the patch. The lines above appear to be getting split incorrectly.

The same thing is seen in PATCH 6/6.

Please rebase the series against linux-next and I'll take another look at is.

Thanks,
Hartley
