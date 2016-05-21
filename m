From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Sat, 21 May 2016 15:00:38 +0300
Subject: [PATCH 0108/1529] Fix typo
In-Reply-To: <20160521115032.4966-1-andrea.gelmini@gelma.net>
References: <20160521115032.4966-1-andrea.gelmini@gelma.net>
Message-ID: <57404DE6.7040506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21.05.2016 14:50, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>   arch/arm/mach-omap2/sdrc.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
> index 645a2a4..f115006 100644
> --- a/arch/arm/mach-omap2/sdrc.h
> +++ b/arch/arm/mach-omap2/sdrc.h
> @@ -175,8 +175,8 @@ u32 omap2xxx_sdrc_reprogram(u32 level, u32 force);
>    * don't adjust it down as your clock period increases the refresh interval
>    * will not be met. Setting all parameters for complete worst case may work,
>    * but may cut memory performance by 2x. Due to errata the DLLs need to be
> - * unlocked and their value needs run time calibration.	A dynamic call is
> - * need for that as no single right value exists acorss production samples.
> + * unlocked and their value needs run time calibration. A dynamic call is
> + * need for that as no single right value exists across production samples.

needed?

>    *
>    * Only the FULL speed values are given. Current code is such that rate
>    * changes must be made at DPLLoutx2. The actual value adjustment for low
>
