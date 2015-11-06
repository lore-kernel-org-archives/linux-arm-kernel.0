From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 6 Nov 2015 09:50:27 +0100
Subject: [PATCH] ARM: shmobile: r8a7793: Add thermal device to DT
In-Reply-To: <1446795048-29767-1-git-send-email-horms+renesas@verge.net.au>
References: <1446795048-29767-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdV-xGYvsSU1xXvB1Z9ssPD0yW_mFg=vre+dyLzs6wmiTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 6, 2015 at 8:30 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> Instantiate the thermal sensor in the r8a7793 device tree.
>
> Based on very similar work for the r8a7790 by Magnus Damm.

Given the similarity of R-Car M2-N and M2-W, I would have referred
to r8a7791 ;-)

> Cc: Magnus Damm <damm@opensource.se>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
