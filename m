From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 10 Dec 2013 14:22:54 +0100
Subject: [PATCH v3 2/3] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <52A64DCB.8000504@cogentembedded.com>
References: <201312082348.17588.sergei.shtylyov@cogentembedded.com>
 <201312082352.45265.sergei.shtylyov@cogentembedded.com>
 <CAMuHMdWFmO4d4b77JDY0_Z5NuQFoP73-PVho2dwAOY4ES57Dug@mail.gmail.com>
 <52A62753.8060202@cogentembedded.com>
 <CAMuHMdXDHMRy2LTEa50omMs0dV9Vdf2woBsNAHzhkceXDfqyOg@mail.gmail.com>
 <52A64DCB.8000504@cogentembedded.com>
Message-ID: <CAMuHMdV6RN4E7xez9xXLbcbp0Ga9zu09ndfa7b_YiobdQypc4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 12:10 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>>>     You can try my simplistic 'sh_eth' driver patch:
>
>>> http://marc.info/?l=linux-sh&m=137911743723032
>
>> Thanks, that also fixes the problem!
>
>    Let's hope Florian's patches get queued for 3.14. You can also test them
> meanwhile...

I applied the whole series "net: phy: consolidate PHY reset", and sh_eth
now works fine on Koelsch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
