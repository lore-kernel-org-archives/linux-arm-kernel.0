From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 10 Dec 2014 11:11:01 +0100
Subject: [PATCH] ARM: shmobile: lager: Fix QSPI mode of SPI-Flash into
 mode3
In-Reply-To: <1418178627-24424-1-git-send-email-horms+renesas@verge.net.au>
References: <1418178627-24424-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXv-12uVasSkLQs6gPYgfaS+O+dBQvDyCswDCTuffvp7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 3:30 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
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
