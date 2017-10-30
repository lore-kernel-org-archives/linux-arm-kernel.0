From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 30 Oct 2017 20:34:51 +0100
Subject: pinctrl: sirf: Use common error handling code in
 sirfsoc_dt_node_to_map()
In-Reply-To: <72b04f56-be81-5a7d-3a43-abac41dd05ba@users.sourceforge.net>
References: <80911d4b-d819-335c-106e-70d7672e645b@users.sourceforge.net>
 <CAMuHMdXSVXZNW7a-xf_zyCW-j_KVQbRBdrt8q-SNjGChuDU-bw@mail.gmail.com>
 <72b04f56-be81-5a7d-3a43-abac41dd05ba@users.sourceforge.net>
Message-ID: <CAMuHMdUH8NgkumbjjOZZrkbD2sdHfVzLwM47U4DUrVC0F7ojDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 8:32 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>>> Add a jump target so that a bit of exception handling can be better reused
>>> at the end of this function.
>>>
>>> This issue was detected by using the Coccinelle software.
>>
>> Does Coccinelle have a threshold for how much cleanup can be shared?
>
> Are you looking for a limitation of such source code search patterns?

Exactly.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
