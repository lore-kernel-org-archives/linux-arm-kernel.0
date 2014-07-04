From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 4 Jul 2014 16:54:58 +0800
Subject: [PATCH v2] MAINTAINERS:ARM:hisi: add Hisilicon SoC family
In-Reply-To: <53B66A9F.6040404@hisilicon.com>
References: <53B66A9F.6040404@hisilicon.com>
Message-ID: <CAD6h2NR+5K35WYPb-4ih0arb=Tqr+Q837i0sXpA12Smims2OEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2014 16:49, xuwei <xuwei5@hisilicon.com> wrote:
> Introduce a new mach-hisi that will support Hisilicon SoCs based on ARMv7
> and I am taking maintainership for it.
>
> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 134483f..a4f700a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -972,6 +972,14 @@ F: arch/arm/mach-pxa/hx4700.c
>  F:     arch/arm/mach-pxa/include/mach/hx4700.h
>  F:     sound/soc/pxa/hx4700.c
>
> +ARM/Hisilicon SoC support
> +M:     Wei Xu <xuwei5@hisilicon.com>
> +L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +W:     www.hisilicon.com
> +S:     Supported
> +T:     git git://github.com/hisilicon/linux-hisi.git
> +F:     arch/arm/mach-hisi/
> +
>  ARM/HP JORNADA 7XX MACHINE SUPPORT
>  M:     Kristoffer Ericson <kristoffer.ericson@gmail.com>
>  W:     www.jlime.com
> --
> 1.8.1.2
>

Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Best Regards
Haojian
