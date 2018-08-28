From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 28 Aug 2018 09:24:20 +0200
Subject: [PATCH] ARM: shmobile: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828015252.28511-2-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-2-robh@kernel.org>
Message-ID: <CAMuHMdV9QeMRSTzcbCeUHFi_a77ceumEW6mzoC+zrpEUsZEM=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 3:54 AM Rob Herring <robh@kernel.org> wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-renesas-soc at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
