From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 3 Jul 2018 15:47:02 +0300
Subject: [PATCH] MAINTAINERS: add Freescale Layerscape ARM architecture
 entry
In-Reply-To: <1530620991-1621-1-git-send-email-shawnguo@kernel.org>
References: <1530620991-1621-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20180703124702.ck64qrdzu33y5zjt@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Jul 03, 2018 at 08:29:51PM +0800, Shawn Guo wrote:
> I have been collecting Freescale Layerscape device tree source files for
> a while.  Add a MAINTAINERS entry for it, so that relevant patches can
> reach my mail box.
> 
> Cc: Li Yang <leoyang.li@nxp.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d5eeff51b5f..d72f1162daea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1442,6 +1442,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
>  F:	arch/arm/mach-imx/*vf610*
>  F:	arch/arm/boot/dts/vf*
>  
> +ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE
> +M:	Shawn Guo <shawnguo@kernel.org>
> +M:	Li Yang <leoyang.li@nxp.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> +F:	arch/arm/boot/dts/ls1021a*
> +F:	arch/arm64/boot/dts/freescale/fsl-*

This pattern would soon (hopefully) match i.MX8 systems.

> +F:	arch/arm64/boot/dts/freescale/qoriq-*
> +
>  ARM/GLOMATION GESBC9312SX MACHINE SUPPORT
>  M:	Lennert Buytenhek <kernel@wantstofly.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
