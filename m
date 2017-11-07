From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 11:06:49 +0100
Subject: [PATCH 7/7] arm64: dts: renesas: r8a7796: Enable IPMMU-DS0, DS1,
 MP, VI0, VC0 and MM
In-Reply-To: <20171101103458.7582-8-horms+renesas@verge.net.au>
References: <20171101103458.7582-1-horms+renesas@verge.net.au>
 <20171101103458.7582-8-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVRsfoSqu1UfiOmMhGGH9JcizFEgnFj+O5YgbvPc3fsfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Enable the r8a7795 device nodes for IPMMU-DS0, IPMMU-DS1, IPMMU-MP,
> IPMMU-VI0, IPMMU-VC0 and the shared IPMMU-MM device.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> [simon: enable IPMMU-MP, VI0 and VC0]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
