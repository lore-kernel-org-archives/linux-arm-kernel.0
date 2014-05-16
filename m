From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 16 May 2014 11:00:24 +0200
Subject: [PATCH v6 13/17] ARM: shmobile: marzen: Add to shmobile defconfig
In-Reply-To: <20140516085135.GA20299@verge.net.au>
References: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
 <1400153532-23675-14-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXPm_=ejkcnOFOgfnsz9MUc8KpAjkuMcHMKJeaEmVbhQA@mail.gmail.com>
 <20140515225027.GA29432@verge.net.au>
 <20140516000409.GB29432@verge.net.au>
 <CAMuHMdWjxK5K4rhJt0VDbsSUX_Gzq8EXCPStN3bb_GUqq8tEog@mail.gmail.com>
 <20140516085135.GA20299@verge.net.au>
Message-ID: <CAMuHMdVgt=iai7CM0xx7jpD9t+mZqZGuTXmTvwfv+ULuDBGWyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 10:51 AM, Simon Horman <horms@verge.net.au> wrote:
>> > --- a/arch/arm/configs/shmobile_defconfig
>> > +++ b/arch/arm/configs/shmobile_defconfig
>>
>> > +CONFIG_USB_RCAR_PHY=y
>> > +CONFIG_USB_RCAR_GEN2_PHY=y
>>
>> While I don't dispute the need for CONFIG_USB_RCAR_GEN2_PHY in
>> shmobile_defconfig, this is not needed for Marzen, right?
>
> The CONFIG_USB_RCAR_GEN2_PHY was moved from above (by savedefconfig).

Sorry, I had missed that.

> I decided to include that change due to proximity to the new
> CONFIG_USB_RCAR_PHY line. But perhaps it would have been better not to.

Nevermind.

BTW, avoiding this moving around in real changes is another reason for
refreshing the defconfigs on a regular basis ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
