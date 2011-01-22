From: marc@cpdesign.com.au (Marc Reilly)
Date: Sat, 22 Jan 2011 17:49:42 +1100
Subject: [PATCH] ARM: imx: Add VPR200 and MX51_3DS entries to uncompress.h
In-Reply-To: <1295633037-3475-1-git-send-email-fabio.estevam@freescale.com>
References: <1295633037-3475-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <201101221749.42185.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, January 22, 2011 05:03:57 am Fabio Estevam wrote:
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/plat-mxc/include/mach/uncompress.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h
> b/arch/arm/plat-mxc/include/mach/uncompress.h index 3a70ebf..ff469c4
> 100644
> --- a/arch/arm/plat-mxc/include/mach/uncompress.h
> +++ b/arch/arm/plat-mxc/include/mach/uncompress.h
> @@ -95,6 +95,7 @@ static __inline__ void __arch_decomp_setup(unsigned long
> arch_id) case MACH_TYPE_MX35_3DS:
>  	case MACH_TYPE_PCM043:
>  	case MACH_TYPE_LILLY1131:
> +	case MACH_TYPE_VPR200:
>  		uart_base = MX3X_UART1_BASE_ADDR;
>  		break;
>  	case MACH_TYPE_MAGX_ZN5:
> @@ -102,6 +103,7 @@ static __inline__ void __arch_decomp_setup(unsigned
> long arch_id) break;
>  	case MACH_TYPE_MX51_BABBAGE:
>  	case MACH_TYPE_EUKREA_CPUIMX51SD:
> +	case MACH_TYPE_MX51_3DS:
>  		uart_base = MX51_UART1_BASE_ADDR;
>  		break;
>  	case MACH_TYPE_MX50_RDP:

Works for me on the vpr (mx35), thanks for adding it in!

Tested-by: Marc Reilly <marc@cpdesign.com.au>

Cheers,
Marc
