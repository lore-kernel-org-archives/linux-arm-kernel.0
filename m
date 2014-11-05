From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 5 Nov 2014 22:01:50 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Clocks Updates for v3.19
In-Reply-To: <CAOesGMhQfUTb_R5EqfH9SCh67bO3UhufPbxR-mf+o1h1G55q0g@mail.gmail.com>
References: <cover.1414558424.git.horms+renesas@verge.net.au>
 <20141104223054.GB5908@quad.lixom.net>
 <CAMuHMdV-h2p5wcPdYL6GPMkO7GafXs9B9h+4hjOPQmfJ37LTXQ@mail.gmail.com>
 <CAOesGMhQfUTb_R5EqfH9SCh67bO3UhufPbxR-mf+o1h1G55q0g@mail.gmail.com>
Message-ID: <CAMuHMdVSSfUjKbfXJUvjYYidUE2Y4ht9f_Rd4Jd1jyHwCUqhQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wed, Nov 5, 2014 at 8:14 PM, Olof Johansson <olof@lixom.net> wrote:
>>>> Geert Uytterhoeven (1):
>>>>       ARM: shmobile: r8a7740 legacy: Add missing INTCA clock for irqpin module
>>>
>>> I'm trying to categorize this patch and it's hard. Is it a fix for a
>>> bug? Support for new firmware that doesn't enable this clock? How does
>>> the breakage show itself, and in what circumstances? Essentially, the
>>> patch description doesn't describe why it's needed and what it fixes.
>>>
>>> Which means I don't know where to merge it to.
>>
>> Unfortunately I've just discovered a stupid typo in that patch.
>> I've sent a fix ("[PATCH] ARM: shmobile: r8a7740 legacy: Fix INTCA
>> clock parent").
>>
>> If you prefer a complete new patch including the fix, just let me know.
>
> Since I haven't applied it yet, feel free to squash it in and send a
> fresh pull request. That way you can revisit the commit message too!

Sent v2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
