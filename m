From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 9 Sep 2014 09:16:34 +0200
Subject: [PATCH/RFC 2/5] PM / Domains: Add DT bindings for the R-Mobile
 System Controller
In-Reply-To: <540E313B.8000305@renesas.com>
References: <1410183344-14756-1-git-send-email-geert+renesas@glider.be>
 <1410183344-14756-3-git-send-email-geert+renesas@glider.be>
 <540E313B.8000305@renesas.com>
Message-ID: <CAMuHMdWRT=ZjXLVtPKJ1ppYLACQhBHJxZRxf6cnGkfC2dLxOOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Khiem-san,

On Tue, Sep 9, 2014 at 12:44 AM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
>> +      - #address-cells: Must be 1,
>> +      - #address-cells: Must be 0.
>
> Should it be "#size-cells: Must be 0." ?

Yes, obviously. Thanks, will fix.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
