From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 24 Oct 2016 10:09:56 +0200
Subject: [PATCH v2] drivers: psci: PSCI checker module
In-Reply-To: <2e2dedf4-192f-8657-10b1-24b426af5f00@arm.com>
References: <20160921143905.36197-1-kevin.brodsky@arm.com>
 <e57565e8-bec9-0460-32d5-fb9f868cc4f8@arm.com>
 <613e4387-0ed5-ad58-7b74-a31b648f81e7@arm.com>
 <2e2dedf4-192f-8657-10b1-24b426af5f00@arm.com>
Message-ID: <CAMuHMdVgccJ0A2d_-uU+8r0h-NBeet3eGkKq14eaFo34ydqtzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 4:21 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 20/10/16 14:38, Kevin Brodsky wrote:
>
> [...]
>
>>
>> Thanks for the heads-up! I'll rebase on 4.9-rc1 and see what needs to be
>> done.
>>
>
> Just be aware that v4.9-rc1 doesn't have commit 9cfb38a7ba5a
> ("sched/fair: Fix sched domains NULL dereference in
> select_idle_sibling()") which fixes the cpuhotplug issue you would
> observe.

Good to know. I saw that issue during resume from s2ram on r8a7795/Salvator-X
once, but couldn't reproduce it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
