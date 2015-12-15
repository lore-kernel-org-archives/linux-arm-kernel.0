From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 15 Dec 2015 11:41:32 +0100
Subject: [PATCH 1/6] clk: shmobile: r8a7795: Add SATA0 clock
In-Reply-To: <1450107758-2544-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1450107758-2544-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <CAMuHMdV7EqSkQUr1MfCWr+y7q9Bura86r92r6wMQZfYb+YiXug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 4:42 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  drivers/clk/shmobile/r8a7795-cpg-mssr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
> index 05479e6..ad4d9fd 100644
> --- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
> +++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
> @@ -159,6 +159,7 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
>         DEF_MOD("gpio2",                 910,   R8A7795_CLK_CP),
>         DEF_MOD("gpio1",                 911,   R8A7795_CLK_CP),
>         DEF_MOD("gpio0",                 912,   R8A7795_CLK_CP),
> +       DEF_MOD("sata0",                 915,   R8A7795_CLK_S3D2),

My datasheet says 815?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
