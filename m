From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sat, 1 Mar 2014 18:33:33 +0100
Subject: [PATCH v3 01/20] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <20140301135002.GA4307@katana>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-2-git-send-email-horms+renesas@verge.net.au>
 <20140301135002.GA4307@katana>
Message-ID: <CAMuHMdV5DTrfY2u1mKA-9Dnjrn9PTDNZ6untMPM9qs7ruGwEKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 1, 2014 at 2:50 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> --- a/include/linux/clk/shmobile.h
>> +++ b/include/linux/clk/shmobile.h
>> @@ -1,7 +1,9 @@
>>  /*
>>   * Copyright 2013 Ideas On Board SPRL
>> + * Copyright 2013 Horms Solutions Ltd.
>>   *
>>   * Contact: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> + * Contact: Simon Horman <horms@verge.net.au>
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>>   * it under the terms of the GNU General Public License as published by
>> @@ -14,6 +16,7 @@
>>
>>  #include <linux/types.h>
>>
>> +void r8a7779_clocks_init(u32 mode);
>>  void rcar_gen2_clocks_init(u32 mode);
>
> Shouldn't the init functions be protected by #ifdef CONFIG_ARCH...?

Not in header files.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
