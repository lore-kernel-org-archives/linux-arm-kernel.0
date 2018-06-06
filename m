From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 6 Jun 2018 10:18:37 +0200
Subject: [PATCH 3/3] arm64: dts: renesas: v3hsk: specify GEther PHY IRQ
In-Reply-To: <9e6c40eb-71d0-d35b-1cf7-9179e093ed10@cogentembedded.com>
References: <4acc208e-c593-1e8a-00ca-fc9a5574074e@cogentembedded.com>
 <9e6c40eb-71d0-d35b-1cf7-9179e093ed10@cogentembedded.com>
Message-ID: <CAMuHMdVf7Og6uBXN7KFQD1u+1xXORCuDC=-ahPpT_xSdmj9CxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 1, 2018 at 10:47 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Specify GEther PHY IRQ in the V3H Starter Kit board's device tree, now
> that we have the GPIO support (previously phylib had to resort to polling).
>
> Based on the original (and large) patch by Vladimir Barinov.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
