From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Mon, 22 Feb 2016 15:24:22 +0200
Subject: [PATCH] MAINTAINERS: alpine: add a new maintainer and update the
 entry
In-Reply-To: <1456147350-7236-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1456147350-7236-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CABM=7knwGCMJsc5WP0NQaVr5vbUNC4XNMxnXDu6ep_rJd8VQnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked -by: Tsahee Zidenberg <tsahee@annapurnalabs.com>


On 22 February 2016 at 15:22, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:
> Add myself as a co-maintainer for the Alpine support. Also update the
> entry to take in account Alpine ARM64 boards, Alpine ARM device trees
> and Alpine-specific drivers.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 30aca4aa5467..53c07990e0f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -938,8 +938,12 @@ N: meson[x68]
>
>  ARM/Annapurna Labs ALPINE ARCHITECTURE
>  M:     Tsahee Zidenberg <tsahee@annapurnalabs.com>
> +M:     Antoine Tenart <antoine.tenart@free-electrons.com>
>  S:     Maintained
>  F:     arch/arm/mach-alpine/
> +F:     arch/arm/boot/dts/alpine*
> +F:     arch/arm64/boot/dts/al/
> +F:     drivers/*/*alpine*
>
>  ARM/ATMEL AT91RM9200, AT91SAM9 AND SAMA5 SOC SUPPORT
>  M:     Nicolas Ferre <nicolas.ferre@atmel.com>
> --
> 2.7.1
>
