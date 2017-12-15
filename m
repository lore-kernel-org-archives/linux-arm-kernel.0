From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 15 Dec 2017 09:53:10 +0100
Subject: [PATCH 1/6] ARM: shmobile: defconfig: Enable PWM
In-Reply-To: <1513248976-26700-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1513248976-26700-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513248976-26700-2-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdWUaQMgT4J0N+hrByAD12K-oO0+iNyDeVczS3nxr5ia9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrizio,

On Thu, Dec 14, 2017 at 11:56 AM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> RZ/G1 and R-Car platforms have PWM timers. This patch enables PWM support
> by default.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Thanks for your patch!

If I'm not mistaken, there are no current users of this PWM block in the
current R-Car Gen2 and RZ/G1 DTS files?
If that's correct, I don't think it makes much sense to enable it already.

Simon: what do you think?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
