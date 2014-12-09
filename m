From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 9 Dec 2014 09:53:04 +0100
Subject: [PATCH] ARM: shmobile: koelsch: Fix QSPI mode of SPI-Flash into
 mode3
In-Reply-To: <1418085432-20374-1-git-send-email-horms+renesas@verge.net.au>
References: <1418085432-20374-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXj9N3tL_9ttw+jU7fxjC8x=JJwXQynMkjOAJp38=L4ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 9, 2014 at 1:37 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> In order to change into mode3, CPOL and CPHA bit of SPCMD register
> of QSPI is changed. Mode3 can avoid intermediate voltage.
>
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> [horms: Updated changelog and re-ordered properties]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
