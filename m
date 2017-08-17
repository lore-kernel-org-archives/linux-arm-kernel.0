From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 17 Aug 2017 15:01:30 +0200
Subject: [PATCH v2] ARM: debug-ll: Add support for r8a7745
In-Reply-To: <1502878810-17011-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1502878810-17011-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdW_XMQGYrKcEmax59ADBD+zNMkNbqZQAPGOAkB0Ja5MJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 12:20 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Enable low-level debugging support for RZ/G1E (r8a7745). RZ/G1E uses
> SCIF4 for the debug console.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
