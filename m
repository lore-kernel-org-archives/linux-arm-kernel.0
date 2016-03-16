From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 16 Mar 2016 09:44:35 +0100
Subject: [PATCH] ARM: dts: r8a7790: Remove unnecessary clock-output-names
 properties
In-Reply-To: <1458089041-22994-1-git-send-email-horms+renesas@verge.net.au>
References: <1458089041-22994-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUsHZDGO_SjEt-TDZ1hr=6eXg87AQ_wBS8A1yKTcSPbqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 1:44 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> * Fixed rate and fixed factor clocks do not require an
>   clock-output-names property.
> * Since 1fae91ec99fb ("clk: shmobile: div6: Extract cpg_div6_register()")
>   Renesas div6 clocks do not require a clock-output-names property.

Are you sure you don't mean its parent, commit 07705583e920fef6
("clk: shmobile: div6: Make clock-output-names optional")? ;-)

> In the above cases there is only one clock output and its name is taken
> from that of the clock node.
>
> Accordingly, remove the unnecessary clock-output-names properties and
> as necessary the nodes.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

With the commit reference fixed:

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
