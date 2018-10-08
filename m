From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 8 Oct 2018 09:05:45 +0200
Subject: [PATCH 05/36] dt-bindings: arm: renesas: Move 'renesas,prr'
 binding to its own doc
In-Reply-To: <20181005165848.3474-6-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-6-robh@kernel.org>
Message-ID: <CAMuHMdV=HaVhGf-7-21OHb05dCc0q9MDUNknAcybEiGSxATeEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Oct 5, 2018 at 6:58 PM Rob Herring <robh@kernel.org> wrote:
> In preparation to convert board-level bindings to json-schema, move
> various misc SoC bindings out to their own file.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-renesas-soc at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Looks good to me, but needs a rebase, as the PRR section has been extended
in -next.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
