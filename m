From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 20 Oct 2017 12:15:03 +0200
Subject: [PATCH] soc: Allow test-building of MediaTek drivers
In-Reply-To: <20171005111743.6367f128@endymion>
References: <20171005111743.6367f128@endymion>
Message-ID: <cd366563-2904-fdba-3cd4-f0ca6d7bc605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/05/2017 11:17 AM, Jean Delvare wrote:
> The COMPILE_TEST alternative dependency allows test-building the
> drivers but only as long as the build system itself will look into
> the directory where the drivers reside.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/soc/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Pushed to v4.14-next/soc

Thanks!

> 
> --- linux-4.14-rc3.orig/drivers/soc/Makefile	2017-09-17 00:47:51.000000000 +0200
> +++ linux-4.14-rc3/drivers/soc/Makefile	2017-10-05 09:44:01.478589469 +0200
> @@ -10,7 +10,7 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
>  obj-y				+= fsl/
>  obj-$(CONFIG_ARCH_MXC)		+= imx/
>  obj-$(CONFIG_SOC_XWAY)		+= lantiq/
> -obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
> +obj-y				+= mediatek/
>  obj-$(CONFIG_ARCH_MESON)	+= amlogic/
>  obj-$(CONFIG_ARCH_QCOM)		+= qcom/
>  obj-y				+= renesas/
> 
> 
