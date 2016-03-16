From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 16 Mar 2016 09:45:52 +0100
Subject: [PATCH v2 1/2] ARM: dts: r8a7793: add CAN clocks to device tree
In-Reply-To: <1458093176-1926-2-git-send-email-horms+renesas@verge.net.au>
References: <1458093176-1926-1-git-send-email-horms+renesas@verge.net.au>
 <1458093176-1926-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXzedXoSWW+9qzNGfCVZbhtZkjvbjwd+QxcsuAxPLkpOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 2:52 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> The R-Car CAN controllers can derive the CAN bus clock not only from their
> peripheral clock input (clkp1) but also from the other internal clock
> (clkp2) and external clock fed on CAN_CLK pin. Describe those clocks in
> the device tree along with  the USB_EXTAL clock from which clkp2 is
> derived.
>
> Based on work by Sergei Shtylyov for the r8a7791 SoC.
>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
