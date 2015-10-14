From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Oct 2015 18:16:41 +0100
Subject: [PATCHv3 07/11] arm64: Kconfig: Fix help text about AArch32
 support with 64K pages
In-Reply-To: <1444821634-1689-8-git-send-email-suzuki.poulose@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-8-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151014171641.GH5041@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 12:20:30PM +0100, Suzuki K. Poulose wrote:
> Update the help text for ARM64_64K_PAGES to reflect the reality
> about AArch32 support.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4654c27..13b51a0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -368,8 +368,8 @@ config ARM64_64K_PAGES
>  	help
>  	  This feature enables 64KB pages support (4KB by default)
>  	  allowing only two levels of page tables and faster TLB
> -	  look-up. AArch32 emulation is not available when this feature
> -	  is enabled.
> +	  look-up. AArch32 emulation requires applications compiled
> +	  with 64K aligned segments.
>  
>  endchoice

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
