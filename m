From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 18 Sep 2015 09:16:31 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.4
In-Reply-To: <cover.1442536920.git.horms+renesas@verge.net.au>
References: <cover.1442536920.git.horms+renesas@verge.net.au>
Message-ID: <CAMuHMdX41ggvKAKrp3s++UMYidhXuASoMP3xzdtnxjoL=0jpSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Sep 18, 2015 at 2:47 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Renesas ARM Based SoC DT Updates for v4.4
>
> * Add missing CPG/MSTP Clock Domain for sound on r8a779[01] SoCs

>       ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain for sound
>       ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain for sound

These two should actually go in in v4.3, as they're bugfixes for commits that
are in v4.3-rc1. That can be done in parallel, though.

Sound will stop working in mainline as soon as commit cbc41d0a761bffb3
("drivers: sh: Disable PM runtime for multi-platform ARM with genpd") in
sh-drivers-for-v4.3 enters mainline.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
