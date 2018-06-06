From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 6 Jun 2018 09:52:24 +0200
Subject: [PATCH 2/2] arm64: dts: renesas: initial V3HSK board device tree
In-Reply-To: <50de037c-7560-c261-f96a-f86065674c9b@cogentembedded.com>
References: <3923fc5f-103c-94c9-57ba-cb29e8c55d05@cogentembedded.com>
 <50de037c-7560-c261-f96a-f86065674c9b@cogentembedded.com>
Message-ID: <CAMuHMdXQMkzunWf=z3NpQvKTuKL_j7q_HStfb_2NU2G-npDPNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 8:12 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the initial device  tree for  the V3H Starter Kit board.
> The board has 1 debug serial port (SCIF0); include support for it,
> so that the serial console can work.
>
> Based on the original (and large) patch by Vladimir Barinov.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

FTR:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- /dev/null
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts

> +&pfc {
> +       scif0_pins: scif0 {
> +               groups = "scif0_data";
> +               function = "scif0";
> +       };

JFYI, hscif0 can be routed to the same pins, if higher performance is needed.


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
