From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 29 Aug 2016 10:03:57 +0200
Subject: [PATCH 2/3] ARM: dts: wheat: initial device tree
In-Reply-To: <4464163.ssfn2FILGm@wasted.cogentembedded.com>
References: <3665116.9BjHTnhfR3@wasted.cogentembedded.com>
 <4464163.ssfn2FILGm@wasted.cogentembedded.com>
Message-ID: <CAMuHMdUTsv=-pFaZDPi8JunUn8suhwyMMOXX3dFJ0WupZKfj_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 10:21 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the initial device tree for the R8A7792  SoC based Wheat board.
> The Wheat board itself has  no serial ports  wired up, the USB serial chips
> are situated on a separate  debug board and  one of them is connected to
> SCFI0  -- include unconditional support for  it, so that the serial console
> can work.
>
> Based  on the original (and large) patch by Vladimir Barinov
> <vladimir.barinov@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
(limited to review that can be done without board documentation)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
