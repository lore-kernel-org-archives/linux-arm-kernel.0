From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 8 Oct 2015 09:32:09 +0800
Subject: [linux-sunxi] [PATCH] MAINTAINERS: Update Allwinner entry and add
 new maintainer
In-Reply-To: <1444239580-32688-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1444239580-32688-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67TFuFQ3ZVHRtzPQHXcM=PAo3Duvt77v9_RtjkJ9_=D1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 8, 2015 at 1:39 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Add Chen-Yu Tsai as a co-maintainer to the ARM sunxi support.
>
> While we are doing so, also update the entry for new SoCs.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 797236befd27..d6a9a016f3d4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -894,11 +894,12 @@ M:        Lennert Buytenhek <kernel@wantstofly.org>
>  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
>
> -ARM/Allwinner A1X SoC support
> +ARM/Allwinner sunXi SoC support
>  M:     Maxime Ripard <maxime.ripard@free-electrons.com>
> +M:     Chen-Yu Tsai <wens@csie.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>

>  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
> -N:     sun[x4567]i
> +N:     sun[x456789]i

I thought we updated this already, in d30dbc6de5732 ("ARM: sunxi: Add sun[89]i
 to MAINTAINERS entry"). It's in your sunxi/core-for-4.4 branch.

>
>  ARM/Allwinner SoC Clock Support
>  M:     Emilio L?pez <emilio@elopez.com.ar>
> --
> 2.5.3
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
