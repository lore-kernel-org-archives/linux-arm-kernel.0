From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 21 Apr 2016 15:38:35 +0200
Subject: [PATCH v3] PCI: rcar-pcie: Remove Gen2 designation from Kconfig
In-Reply-To: <1461210715-29304-1-git-send-email-horms+renesas@verge.net.au>
References: <1461210715-29304-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXtVvNERECxbp1EtJ1SNOQG-j_xtV3NpsGqgyDLmc7cOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 5:51 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> It appears that Gen2 is a misnomer for the R-Car PCIE driver
> which also supports Gen 1 and Gen 3 SoCs. Accordingly, drop Gen 2
> from the help text and Kconfig symbol.
>
> Also, re-arange the Kconfig symbol name to use PCIE as the prefix.
> This appears to be in keeping with other PCIE Kconfig symbols.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
