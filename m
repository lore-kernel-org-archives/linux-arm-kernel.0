From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 12:13:10 +0100
Subject: [PATCH 20/24] msm: MSM8X60 simulator board support
In-Reply-To: <1282712273-344-21-git-send-email-johlstei@codeaurora.org>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
	<1282712273-344-21-git-send-email-johlstei@codeaurora.org>
Message-ID: <20100902111310.GY26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 24, 2010 at 09:57:49PM -0700, Jeff Ohlstein wrote:
> From: Steve Muckle <smuckle@codeaurora.org>
> 
> Board configuration for MSM8X60 simulation.
> 
> Signed-off-by: Steve Muckle <smuckle@codeaurora.org>
> ---
>  arch/arm/mach-msm/Kconfig         |    7 +++++++
>  arch/arm/mach-msm/Makefile        |    1 +
>  arch/arm/mach-msm/board-msm8x60.c |   10 +++++++++-
>  3 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
> index 3017e12..d2610a3 100644
> --- a/arch/arm/mach-msm/Kconfig
> +++ b/arch/arm/mach-msm/Kconfig
> @@ -105,6 +105,13 @@ config MACH_MSM8X60_SURF
>  	help
>  	  Support for the Qualcomm MSM8x60 SURF eval board.
>  
> +config MACH_MSM8X60_SIM
> +	depends on ARCH_MSM8X60
> +	default n

All these 'default n' statements can be removed - n is the default anyway.
