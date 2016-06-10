From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 10 Jun 2016 09:54:22 +0200
Subject: [PATCH/RFC v3 02/22] soc: renesas: Add R-Car RST driver
In-Reply-To: <6849015.bJCuAeaMgZ@avalon>
References: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
 <1464808880-343-3-git-send-email-geert+renesas@glider.be>
 <6849015.bJCuAeaMgZ@avalon>
Message-ID: <CAMuHMdUX+DqPyo4cTJnNyinc2zgB-0CtUBmyjQjFEKWmV_Y-Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Thu, Jun 2, 2016 at 11:58 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- /dev/null
>> +++ b/drivers/soc/renesas/rcar-rst.c

>> +static int __init rcar_rst_init(void)
>> +{

[...]

>> +}
>> +arch_initcall(rcar_rst_init);
>
> Given that rcar_rst_init() is only used as a support function for
> rcar_rst_read_mode_pins(), how about removing the initcall ?

Thanks, good idea!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
