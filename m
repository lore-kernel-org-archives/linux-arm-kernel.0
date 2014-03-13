From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 13 Mar 2014 09:28:23 +0100
Subject: [PATCH 0/2] ARM: shmobile: koelsch, lager: Annotate clk_names
 with __initconst
In-Reply-To: <1394692198-30715-1-git-send-email-horms+renesas@verge.net.au>
References: <1394692198-30715-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXpXDv8C6b1T+LyE8BSnhdD4dPq_HF6O3OY7Aev+EFfXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 7:29 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add __initconst annotations to recently added clk_names.
>
> Depends on
> "[PATCH v2 00/03] ARM: shmobile: Break out and extend clock workaround V2"
>
> Simon Horman (2):
>   ARM: shmobile: koelsch: Annotate clk_names with __initconst
>   ARM: shmobile: lager: Annotate clk_names with __initconst

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
