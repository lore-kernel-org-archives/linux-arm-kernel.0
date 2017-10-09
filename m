From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 9 Oct 2017 13:58:25 +0200
Subject: [PATCH v2 1/2] arm64: dts: r8a7795: Add OPPs table for cpu devices
In-Reply-To: <1507209984-17123-2-git-send-email-horms+renesas@verge.net.au>
References: <1507209984-17123-1-git-send-email-horms+renesas@verge.net.au>
 <1507209984-17123-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdX-EGVuyM=ieAw3TBObL04FqH3cGcYRwdGG8wwNmVnwLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Oct 5, 2017 at 3:26 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
>
> Current, OPP tables are defined temporary,
> they are being evaluated and adjust in future.
>
> Based in part on work by Hien Dang.
>
> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> v2 [Simon Horman]
> - Only provide one operating points node for each operating-points-v2 node
>   as per the binding; other nodes were unused and have been removed

Thanks for the update!

I think all comments for "[PATCH v2 2/2] arm64: dts: r8a7796: Add OPPs table
for cpu devices" apply here, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
