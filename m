From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 19 Jul 2017 10:01:16 +0200
Subject: [PATCH] soc: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-49-robh@kernel.org>
References: <20170718214339.7774-49-robh@kernel.org>
Message-ID: <CAMuHMdUzoTMV3qvFckzHMDt6Xk8G9-PJDeVu-PCN-XhwUQx_uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 11:43 PM, Rob Herring <robh@kernel.org> wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
