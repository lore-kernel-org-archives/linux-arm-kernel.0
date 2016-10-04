From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 4 Oct 2016 15:37:35 +0200
Subject: [PATCH v2 5/7] arm64: dts: exynos: Add dts files for Samsung
 Exynos5433 64bit SoC
In-Reply-To: <1472046551-703-6-git-send-email-cw00.choi@samsung.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-6-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAMuHMdV3WdS75QXsJgEXirqV-d=RJa-LTq4OdvS6fgQWS+DO-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 3:49 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi

> +       cluster_a53_opp_table: opp_table0 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               opp at 400000000 {
> +                       opp-hz = /bits/ 64 <400000000>;
> +                       opp-microvolt = <900000>;
> +               };

With W=1:

Warning (unit_address_vs_reg): Node /opp_table0/opp at 400000000 has a
unit name, but no reg property
...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
