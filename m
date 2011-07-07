From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 7 Jul 2011 20:51:32 +0400
Subject: [PATCH] ARM: make CNS3XXX select CPU_V6K
In-Reply-To: <1310033949-25590-1-git-send-email-kaloz@openwrt.org>
References: <1310033949-25590-1-git-send-email-kaloz@openwrt.org>
Message-ID: <20110707165131.GB1242@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 12:19:09PM +0200, Imre Kaloz wrote:
> CNS3XXX is based on MPCore, so select the right CPU option for it.
> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> ---

Applied, thanks!

>  arch/arm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9adc278..c2e5f3d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -321,7 +321,7 @@ config ARCH_CLPS711X
>  
>  config ARCH_CNS3XXX
>  	bool "Cavium Networks CNS3XXX family"
> -	select CPU_V6
> +	select CPU_V6K
>  	select GENERIC_CLOCKEVENTS
>  	select ARM_GIC
>  	select MIGHT_HAVE_PCI

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
