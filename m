From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Dec 2014 22:06:51 +0800
Subject: [PATCH] MAINTAINERS: add Freescale Vybrid SoC
In-Reply-To: <1417131235-3077-1-git-send-email-stefan@agner.ch>
References: <1417131235-3077-1-git-send-email-stefan@agner.ch>
Message-ID: <20141202140649.GJ2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 12:33:55AM +0100, Stefan Agner wrote:
> Add Freescale Vybrid family as a own entry, along with an entry for
> the so far orphan Vybrid device tree files. Also add myself as
> a designated reviewer.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
> Not sure if this is acceptable, but it would be nice when I get Vybrid
> related stuff automatically...
> 
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c64271..6837f23 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -990,6 +990,16 @@ F:	arch/arm/mach-mxs/
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
> -- 
> 2.1.3
> 
