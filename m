From: robh@kernel.org (Rob Herring)
Date: Wed, 27 Aug 2014 07:08:04 -0500
Subject: [PATCH] MAINTAINERS: Add dts and dtsi files to Calxeda Highbank
 ARM platform
In-Reply-To: <1409113103-15937-1-git-send-email-horms+renesas@verge.net.au>
References: <1409113103-15937-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAL_JsqLPrvTHq4AYap5bRxXm0m=fBaMN4gsbzD_nuKv1-j_s6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:18 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks.

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 94fcad9..5ed5734 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -859,6 +859,8 @@ M:  Rob Herring <robh@kernel.org>
>  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     arch/arm/mach-highbank/
> +F:     arch/arm/boot/dts/ecx-2000.dts
> +F:     arch/arm/boot/dts/ecx-common.dtsi

You missed highbank.dts though.
