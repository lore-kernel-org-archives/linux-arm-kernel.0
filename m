From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 19 May 2016 18:58:11 +0200
Subject: [PATCH/RFC 2/3] arm64: dts: salvator-x: add Salvator-X board on
 R8A7796 SoC
In-Reply-To: <1463629845-7115-3-git-send-email-horms+renesas@verge.net.au>
References: <1463629845-7115-1-git-send-email-horms+renesas@verge.net.au>
 <1463629845-7115-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVTMvDsmO1g=FNwpkvx_56guHk_V6Katj8e3qOdyQsjeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2016 at 5:50 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> @@ -0,0 +1,45 @@

> +       chosen {
> +               bootargs = "ignore_loglevel";

Perhaps you want this to be consistent with the other Renesas boards?

git grep bootargs -- $(git grep -l renesas, -- arch/arm*/*dts)

> +               stdout-path = "serial0:115200n8";
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
