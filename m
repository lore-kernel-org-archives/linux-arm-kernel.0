From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 25 Jan 2015 20:30:33 +0100
Subject: [PATCH] ARM: shmobile: henninger: rename board to Porter
In-Reply-To: <2481726.lh33apx2TG@wasted.cogentembedded.com>
References: <2481726.lh33apx2TG@wasted.cogentembedded.com>
Message-ID: <CAMuHMdW3NmzGxGa9DOHpk4Evjg=+bduUPiMoRZT9Ko7+jNp-Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Jan 23, 2015 at 9:37 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Renesas has made some changes to the Henninger low cost board hardware and at
> the same time decided to  rename the board  to Porter.

Which changes? They're not reflected in the new DTS?

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against 'renesas-devel-20150123-v3.19-rc5' tag of Simon Horman's
> 'renesas.git' repo.
>
>  arch/arm/boot/dts/Makefile                                     |  2 +-
>  .../arm/boot/dts/{r8a7791-henninger.dts => r8a7791-porter.dts} | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>  rename arch/arm/boot/dts/{r8a7791-henninger.dts => r8a7791-porter.dts} (96%)

You forgot to update Documentation/devicetree/bindings/arm/shmobile.txt

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
