From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu, 08 Nov 2012 06:57:51 +0100
Subject: [PATCH] [TRIVIAL] ARM: cns3xxx: drop unnessesary symbol selection
In-Reply-To: <1352353029-2725-1-git-send-email-kaloz@openwrt.org>
References: <1352353029-2725-1-git-send-email-kaloz@openwrt.org>
Message-ID: <op.wnfxipt02s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s/unnessesary/unnecessary/ -- I should sleep more ;)

On Thu, 08 Nov 2012 06:37:09 +0100, Imre Kaloz <kaloz@openwrt.org> wrote:

> ARCH_CNS3XXX already selects MIGHT_HAVE_PCI, so boards don't have to
>
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> ---
>  arch/arm/mach-cns3xxx/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
> index 29b13f2..9ebfcc4 100644
> --- a/arch/arm/mach-cns3xxx/Kconfig
> +++ b/arch/arm/mach-cns3xxx/Kconfig
> @@ -3,7 +3,6 @@ menu "CNS3XXX platform type"
> config MACH_CNS3420VB
>  	bool "Support for CNS3420 Validation Board"
> -	select MIGHT_HAVE_PCI
>  	help
>  	  Include support for the Cavium Networks CNS3420 MPCore Platform
>  	  Baseboard.
