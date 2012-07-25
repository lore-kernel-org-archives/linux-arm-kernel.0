From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 12:38:43 +0000
Subject: [PATCH] ARM: versatile: Don't use platform clock for Integrator &
 VE
In-Reply-To: <1343213374-30088-1-git-send-email-pawel.moll@arm.com>
References: <1343213374-30088-1-git-send-email-pawel.moll@arm.com>
Message-ID: <201207251238.44337.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, Pawel Moll wrote:
> Due to automatic merge of a613163dff04cbfcb7d66b06ef4a5f65498ee59b
> "ARM: integrator: convert to common clock" and
> 56a34b03ff427046494db87f05fc810aaedd23a5 "ARM: versatile: Make
> plat-versatile clock optional" two platforms: Integrator and
> Versatile Express now select both COMMON_CLK and
> PLAT_VERSATILE_CLOCK which breaks building them. Fixed now.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/Kconfig |    2 --
>  1 file changed, 2 deletions(-)
> 
> Arnd, Olof,
> 
> Would you consider adding this patch to one of your late pull
> requests for 3.6 or do you want me to wait till 3.6-rc1?

Applied to the fixes branch. I still don't see why this happened,
but the result is obviously broken and your patch looks good.

	Arnd
