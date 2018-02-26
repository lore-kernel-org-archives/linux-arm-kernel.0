From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Feb 2018 19:17:41 +0100
Subject: [PATCH 3/8] arm64: dts: renesas: r8a7795: Set EtherAVB phy mode
 to "rgmii"
In-Reply-To: <1519667836-31330-4-git-send-email-jacopo+renesas@jmondi.org>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519667836-31330-4-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdXFa=t4F6gtwq4PnSjyXchbCoETjkphgy-A_RYMWyOnBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 6:57 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Set the "phy-mode" property of EtherAVB device to "rgmii" and let board
> files override it if the installed PHY layer provides delays for the
> RX/TX channels.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

But you need a patch to update ulcb.dtsi first.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
