From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 23 May 2018 13:52:32 +0200
Subject: [PATCH] ARM: dts: porter: Add missing PMIC nodes
In-Reply-To: <20180523114340.10216-1-marek.vasut+renesas@gmail.com>
References: <20180523114340.10216-1-marek.vasut+renesas@gmail.com>
Message-ID: <CAMuHMdVCPEChhbHsc1Tcp-zkBY5v8Mz+8qq-v3GVFifL_uLyeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Wed, May 23, 2018 at 1:43 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Add PMIC nodes to Porter and connect CPU DVFS supply. There is
> one DA9063L and one DA9210 on Porter, the only difference from
> the other boards is that DA9063L is at I2C address 0x5a rather
> than 0x58 .

Ah, so porter needs the regulator quirk, too.

> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
