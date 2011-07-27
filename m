From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 27 Jul 2011 15:57:07 +0530
Subject: [PATCH v2] OMAP: ctrl: Fix CONTROL_DSIPHY register fields
In-Reply-To: <1311762839-31663-1-git-send-email-archit@ti.com>
References: <1311762839-31663-1-git-send-email-archit@ti.com>
Message-ID: <4E2FE7FB.2020005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/27/2011 4:03 PM, Archit Taneja wrote:
> Fix the shift and mask macros for DSIx_PPID fields in CONTROL_DSIPHY. The
> OMAP4430 Public TRM vV has these fields mentioned correctly.
>
> Signed-off-by: Archit Taneja<archit@ti.com>
> Acked-by: Benoit Cousson<b-cousson@ti.com>
> ---
> v2:
> - Improve commit description.
> - Define fields in decreasing order of the field's end bit.
>
Thanks for the update.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

>   .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
> index c88420d..1e2d332 100644
> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
> +++ b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
> @@ -941,10 +941,10 @@
>   #define OMAP4_DSI2_LANEENABLE_MASK				(0x7<<  29)
>   #define OMAP4_DSI1_LANEENABLE_SHIFT				24
>   #define OMAP4_DSI1_LANEENABLE_MASK				(0x1f<<  24)
> -#define OMAP4_DSI1_PIPD_SHIFT					19
> -#define OMAP4_DSI1_PIPD_MASK					(0x1f<<  19)
> -#define OMAP4_DSI2_PIPD_SHIFT					14
> -#define OMAP4_DSI2_PIPD_MASK					(0x1f<<  14)
> +#define OMAP4_DSI2_PIPD_SHIFT					19
> +#define OMAP4_DSI2_PIPD_MASK					(0x1f<<  19)
> +#define OMAP4_DSI1_PIPD_SHIFT					14
> +#define OMAP4_DSI1_PIPD_MASK					(0x1f<<  14)
>
>   /* CONTROL_MCBSPLP */
>   #define OMAP4_ALBCTRLRX_FSX_SHIFT				31
