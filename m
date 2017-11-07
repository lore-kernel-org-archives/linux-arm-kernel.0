From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 11:14:20 +0100
Subject: [PATCH 2/2] arm64: dts: renesas: r8a77995: Connect Ethernet-AVB
 to IPMMU-RT
In-Reply-To: <20171101103508.7721-3-horms+renesas@verge.net.au>
References: <20171101103508.7721-1-horms+renesas@verge.net.au>
 <20171101103508.7721-3-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXzC=Aao91RbaDAq-mm8Wyniv+BmfCh6QibjQsGZO6snw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:35 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add IPMMU-RT to the Ethernet-AVB device node.
>
> Based on work by Magnus Damm for the r8a7795.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
