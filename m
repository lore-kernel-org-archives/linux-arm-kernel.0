From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 23 Oct 2012 13:48:19 +0400
Subject: [PATCH RESEND] ARM: dm365: replace V4L2_OUT_CAP_CUSTOM_TIMINGS
 with V4L2_OUT_CAP_DV_TIMINGS
In-Reply-To: <1350907972-11256-1-git-send-email-prabhakar.lad@ti.com>
References: <1350907972-11256-1-git-send-email-prabhakar.lad@ti.com>
Message-ID: <508667E3.4000509@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-10-2012 16:12, Prabhakar Lad wrote:

> From: Lad, Prabhakar <prabhakar.lad@ti.com>

> This patch replaces V4L2_OUT_CAP_CUSTOM_TIMINGS macro with
> V4L2_OUT_CAP_DV_TIMINGS. As V4L2_OUT_CAP_CUSTOM_TIMINGS is being phased
> out.

> Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> ---
>   Resending the patch since, it didn't reach the DLOS mailing list.

>   This patch is based on the following patch series,
>   ARM: davinci: dm365 EVM: add support for VPBE display
>   (https://patchwork.kernel.org/patch/1295071/)

>   arch/arm/mach-davinci/board-dm365-evm.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
> index 2924d61..771abb5 100644
> --- a/arch/arm/mach-davinci/board-dm365-evm.c
> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
> @@ -514,7 +514,7 @@ static struct vpbe_output dm365evm_vpbe_outputs[] = {
>   			.index		= 1,
>   			.name		= "Component",
>   			.type		= V4L2_OUTPUT_TYPE_ANALOG,
> -			.capabilities	= V4L2_OUT_CAP_CUSTOM_TIMINGS,
> +			.capabilities	=  V4L2_OUT_CAP_DV_TIMINGS,

    Why this extra space after '='?

WBR, Sergei
