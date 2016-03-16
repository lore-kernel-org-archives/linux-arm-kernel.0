From: ddaney@caviumnetworks.com (David Daney)
Date: Wed, 16 Mar 2016 16:26:00 -0700
Subject: [PATCH] phy: mdio-thunder: Fix some Kconfig typos
In-Reply-To: <1458170617-31784-1-git-send-email-afaerber@suse.de>
References: <1458170617-31784-1-git-send-email-afaerber@suse.de>
Message-ID: <56E9EB88.5000608@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2016 04:23 PM, Andreas F?rber wrote:
> Drop two extra occurrences of "on" in option title and help text.
>
> Fixes: 379d7ac7ca31 ("phy: mdio-thunder: Add driver for Cavium Thunder SoC MDIO buses.")
> Cc: David Daney <david.daney@cavium.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

FWIW:

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   drivers/net/phy/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 075a4cc175b1..6dad9a9c356c 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -197,13 +197,13 @@ config MDIO_OCTEON
>   	  drivers on some systems.
>
>   config MDIO_THUNDER
> -	tristate "Support for MDIO buses on on ThunderX SOCs"
> +	tristate "Support for MDIO buses on ThunderX SOCs"
>   	depends on 64BIT
>   	depends on PCI
>   	select MDIO_CAVIUM
>   	help
>   	  This driver supports the MDIO interfaces found on Cavium
> -	  ThunderX SoCs when the MDIO bus device appears on as a PCI
> +	  ThunderX SoCs when the MDIO bus device appears as a PCI
>   	  device.
>
>
>
