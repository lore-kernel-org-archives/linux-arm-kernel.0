From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 24 Sep 2014 14:24:26 +0200
Subject: [PATCH 3/3] ARM: shmobile: Initial Alt board device tree
In-Reply-To: <a742795be9ceae2853ca71f216193f29da151da8.1410396013.git.horms+renesas@verge.net.au>
References: <cover.1410396013.git.horms+renesas@verge.net.au>
 <a742795be9ceae2853ca71f216193f29da151da8.1410396013.git.horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXx7OmH0WC_MxsYB0X4=yomLtf+HoE8YUBo0aTPHT2zNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 2:57 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7794-alt.dts

> +/ {
> +       model = "Alt";
> +       compatible = "renesas,alt", "renesas,r8a7794";
> +
> +       aliases {
> +               serial0 = &scif2;

Is this correct, i.e. does "scif2" match "ttySC0" below?

> +       };
> +
> +       chosen {
> +               bootargs = "console=ttySC0,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp";
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
