From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 Feb 2018 11:02:55 +0100
Subject: [PATCH v2 2/2] arm64: dts: renesas: eagle: specify EtherAVB PHY
 IRQ
In-Reply-To: <0ccd631e-691a-2b15-7680-6e0c847a6ca2@cogentembedded.com>
References: <038a791d-aa57-9c3d-eaea-09c5704ecb54@cogentembedded.com>
 <0ccd631e-691a-2b15-7680-6e0c847a6ca2@cogentembedded.com>
Message-ID: <CAMuHMdX3XZSwvAT74fVhWw9GoxVmpdXoqR03=u0QC3FEB==X=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 12:24 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Specify  EtherAVB PHY IRQ  in the Eagle board's device tree, now that we
> have the GPIO support (previously phylib had to resort to polling).
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

You've dropped my:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
