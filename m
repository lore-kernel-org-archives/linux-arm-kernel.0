From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Sep 2018 10:52:23 +0200
Subject: [PATCH 05/21] ARM: shmobile: use for_each_of_cpu_node iterator
In-Reply-To: <20180905193738.19325-6-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-6-robh@kernel.org>
Message-ID: <CAMuHMdVaxahVjR2NmfYmt8ELaaDoZdfL3WeDJ8oxS8JxOsjPxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2018 at 9:38 PM Rob Herring <robh@kernel.org> wrote:
> Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
> has the side effect of defaulting to iterating using "cpu" node names in
> preference to the deprecated (for FDT) device_type == "cpu".
>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
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
