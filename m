From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 20 Feb 2014 19:08:19 +0100
Subject: [RFC/PATCH] ARM: mvebu: Rename the ARCH_MVEBU menu option
In-Reply-To: <1392917894-3444-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392917894-3444-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140220180819.GR11878@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 02:38:14PM -0300, Ezequiel Garcia wrote:
> The previous name "Marvell SOCs with Device Tree support" is a bit
> ambiguous and not too informative for users. Instead, use a more
> appropriate name.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Hi everyone,
> 
> The previous name is clearly misleading and has been bothering me since
> a long time. Here's my proposal, mostly meant to just to kick-start the
> discussion.
> 
>  arch/arm/mach-mvebu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 5e269d7..b9ba634 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -1,5 +1,5 @@
>  config ARCH_MVEBU
> -	bool "Marvell SOCs with Device Tree support" if ARCH_MULTI_V7
> +	bool "Marvell Engineering Business Unit (MVEBU) SoCs" if ARCH_MULTI_V7

They are all DT and the general trend is to only DT, so removing that
part makes sense. Defining what MVEBU means also makes sense. So:

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
