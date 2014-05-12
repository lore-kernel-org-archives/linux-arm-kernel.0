From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 12 May 2014 09:25:21 +0200
Subject: [PATCH v4] drivers: sh: compile drivers/sh/pm_runtime.c if
 ARCH_SHMOBILE_MULTI
In-Reply-To: <20140512070700.GA20505@verge.net.au>
References: <1399411579-10681-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdWwenyU1RS4c8spFcb7M0oCXP9z8zbGQ0VACKj7EbvvkA@mail.gmail.com>
 <20140511004626.GW31760@verge.net.au>
 <CANqRtoQzxdjwU+BLyccrSzfBx3UMKm6=MAw9dUHSEBWm5_Vspg@mail.gmail.com>
 <20140512070700.GA20505@verge.net.au>
Message-ID: <CAMuHMdVMCcDK4Y403G26S27oATzLN74iCSM7U+K_ktE-c3uweQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, May 12, 2014 at 9:07 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, May 12, 2014 at 08:24:03AM +0900, Magnus Damm wrote:
>> On Sun, May 11, 2014 at 9:46 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Thu, May 08, 2014 at 12:12:29PM +0200, Geert Uytterhoeven wrote:
>> >> On Tue, May 6, 2014 at 11:26 PM, Geert Uytterhoeven
>> >> <geert+renesas@glider.be> wrote:
>> >> > Tested on Koelsch (legacy, reference, shmobile, and shmobile+bbb kernels)
>> >> > and BeagleBone Black (shmobile+bbb). Will test on more hardware tomorrow.
>> >>
>> >> Tested on genmai with Wolfram's CCF support.
>> >
>> > Thanks, shall I go ahead and queue this up?
>>
>> Yes please, at least from my side everything looks perfect.
>
> Thanks, will do.
>
> I currently plan to send this on to Linus when the merge window
> opens for v3.16.

Actually we had hoped this could land in v3.15, so we can fix the regression
introduced in v3.14 by bf98c1eac1d4a6bcf00532e4fa41d8126cd6c187 as
soon as possible.

> This differs from other patches I have queued up (until now) which
> I have or intend to send via the ARM SoC tree.

Yep ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
