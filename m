From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 04 Jul 2014 16:54:53 +0400
Subject: [PATCH v2] MAINTAINERS:ARM:hisi: add Hisilicon SoC family
In-Reply-To: <53B66A9F.6040404@hisilicon.com>
References: <53B66A9F.6040404@hisilicon.com>
Message-ID: <53B6A41D.1030000@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/04/2014 12:49 PM, xuwei wrote:

> Introduce a new mach-hisi that will support Hisilicon SoCs based on ARMv7
> and I am taking maintainership for it.

> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 134483f..a4f700a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -972,6 +972,14 @@ F:	arch/arm/mach-pxa/hx4700.c
>   F:	arch/arm/mach-pxa/include/mach/hx4700.h
>   F:	sound/soc/pxa/hx4700.c
>
> +ARM/Hisilicon SoC support

    This line is traditionally written in upper case.

> +M:	Wei Xu <xuwei5@hisilicon.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +W:	www.hisilicon.com

    How about http://?

> +S:	Supported
> +T:	git git://github.com/hisilicon/linux-hisi.git
> +F:	arch/arm/mach-hisi/
> +

WBR, Sergei
