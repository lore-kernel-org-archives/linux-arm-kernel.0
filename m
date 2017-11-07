From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 11:07:59 +0100
Subject: [PATCH v4 14/15] arm64: dts: renesas: r8a7795: Enable IPMMU-VI,
 VP, DS0, DS1 and MM
In-Reply-To: <20171101103452.7491-15-horms+renesas@verge.net.au>
References: <20171101103452.7491-1-horms+renesas@verge.net.au>
 <20171101103452.7491-15-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdV80LSM6YhRfbvsXQiSbDe6zqGqV51fdyeTFAmDDH06Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Enable the r8a7795 device nodes for IPMMU-VI, IPMMU-VP, IPMMU-DS0,

VI0, VP0

> IPMMU-DS1 and the shared IPMMU-MM device.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
