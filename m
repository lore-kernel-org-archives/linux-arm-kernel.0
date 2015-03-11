From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 15:31:02 +0100
Subject: [PATCH] MAINTAINERS: add Freescale Vybrid SoC
In-Reply-To: <1425251342-2795-1-git-send-email-stefan@agner.ch>
References: <1425251342-2795-1-git-send-email-stefan@agner.ch>
Message-ID: <2855369.N1Q0M7fuE5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 March 2015 00:09:02 Stefan Agner wrote:
> Add Freescale Vybrid family as a own entry, along with an entry for
> the so far orphan Vybrid device tree files. Also add myself as
> a designated reviewer.
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> This hasn't made it into the kernel since quite some time, not sure
> who would I normally address this to?
> 
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddc5a8c..0188250 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1030,6 +1030,16 @@ F:	arch/arm/mach-mxs/
>  F:	arch/arm/boot/dts/imx*
>  F:	arch/arm/configs/imx*_defconfig
>  
> +ARM/FREESCALE VYBRID ARM ARCHITECTURE
> +M:	Shawn Guo <shawn.guo@linaro.org>
> +M:	Sascha Hauer <kernel@pengutronix.de>
> +R:	Stefan Agner <stefan@agner.ch>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> +F:	arch/arm/mach-imx/*vf610*
> +F:	arch/arm/boot/dts/vf*
> +
>  ARM/GLOMATION GESBC9312SX MACHINE SUPPORT
>  M:	Lennert Buytenhek <kernel@wantstofly.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> 

Applied to fixes branch, thanks,

	Arnd
