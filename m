From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 30 Dec 2013 10:19:48 -0800
Subject: [PATCH] MAINTAINERS: Update Allwinner sunXi maintainer files
In-Reply-To: <1388415813-6673-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1388415813-6673-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAPtuhTjSnr0yJXFhZN7UYAXf1RN8c1LaX82XLTDPrD+iSqdb3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 7:03 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Add entries for all files having either sunxi or one of the Allwinner flavours
> in their name.
>
> Also elect Emilio Lopez as the maintainer of the clock driver, since he was
> already acting like it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
>  MAINTAINERS | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1344816..dc39230 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -766,7 +766,12 @@ ARM/Allwinner A1X SoC support
>  M:     Maxime Ripard <maxime.ripard@free-electrons.com>
>  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
> -F:     arch/arm/mach-sunxi/
> +N:     sun[x4567]i
> +
> +ARM/Allwinner SoC Clock Support
> +M:     Emilio L?pez <emilio@elopez.com.ar>
> +S:     Maintained
> +F:     drivers/clk/sunxi/
>
>  ARM/ATMEL AT91RM9200 AND AT91SAM ARM ARCHITECTURES
>  M:     Andrew Victor <linux@maxim.org.za>
> --
> 1.8.4.2
>
