From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 10:54:17 +0100
Subject: [PATCH 1/7] arm64: dts: renesas: r8a7796: Add IPMMU device nodes
In-Reply-To: <20171101103458.7582-2-horms+renesas@verge.net.au>
References: <20171101103458.7582-1-horms+renesas@verge.net.au>
 <20171101103458.7582-2-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWdPmU=16B8BbfTD316MWOGVVhb4-vcg7yr-JBLKDwjdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Add r8a7796 IPMMU nodes and keep all disabled by default.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> [simon: update names]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

My comments for r8a7795.dtsi about IPMMU-* comments and power-domains
properties are applicable here, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
