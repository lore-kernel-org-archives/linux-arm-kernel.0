From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 25 Feb 2014 14:06:45 +0100
Subject: [PATCHv2 1/5] ARM: tegra: remove obsolete gpio entries
In-Reply-To: <1393330950-7283-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1393330950-7283-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1393330950-7283-2-git-send-email-heikki.krogerus@linux.intel.com>
Message-ID: <5570705.i8uRb6OetD@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heikki,

Am Dienstag, 25. Februar 2014, 14:22:26 schrieb Heikki Krogerus:
> After moving to description based gpio interface in
> rfkill-gpio, the gpio numbers are not used any more.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Marc Dietrich <marvin24@gmx.de>

Thanks for taking care!

Marc

> ---
>  arch/arm/mach-tegra/board-paz00.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-paz00.c
> b/arch/arm/mach-tegra/board-paz00.c index e4dec9f..9c6029b 100644
> --- a/arch/arm/mach-tegra/board-paz00.c
> +++ b/arch/arm/mach-tegra/board-paz00.c
> @@ -23,9 +23,7 @@
>  #include "board.h"
> 
>  static struct rfkill_gpio_platform_data wifi_rfkill_platform_data = {
> -	.name		= "wifi_rfkill",
> -	.reset_gpio	= 25, /* PD1 */
> -	.shutdown_gpio	= 85, /* PK5 */
> +	.name	= "wifi_rfkill",
>  	.type	= RFKILL_TYPE_WLAN,
>  };
