From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 19 Jun 2017 10:42:18 +0200
Subject: [PATCH] ARM: dts: iwg20d-q7: Add pinctl support for scif0
In-Reply-To: <1497625049-46802-1-git-send-email-biju.das@bp.renesas.com>
References: <1497625049-46802-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <CAMuHMdVe7sRcGohSPvSUrryNMetddomoMbN7ffOtq9Y3DBt=zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Biju,

On Fri, Jun 16, 2017 at 4:57 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> Adding pinctrl support for scif0 interface.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

The patch looks good to me, but without schematics, we cannot verify the
actual pins used.

Are the schematics somewhere available? Having access to them would allow us
doing a better job reviewing your DTS patches.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
