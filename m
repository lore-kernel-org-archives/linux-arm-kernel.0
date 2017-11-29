From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 29 Nov 2017 09:30:03 +0100
Subject: [PATCH v4] ARM: dts: r8a7794: Add SMP support
In-Reply-To: <20171129082636.zwbwetif6vuxxfww@verge.net.au>
References: <1511876341-8639-1-git-send-email-geert+renesas@glider.be>
 <20171129082636.zwbwetif6vuxxfww@verge.net.au>
Message-ID: <CAMuHMdWE6=3FaCxjuaLAK4HJdP4UoGXiBJkrdWVXYA6ZR+7uuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Nov 29, 2017 at 9:26 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Nov 28, 2017 at 02:39:01PM +0100, Geert Uytterhoeven wrote:
>> From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> Add the device tree node for the Advanced Power Management Unit (APMU).
>> Use the "enable-method" prop to  point out that the APMU should be used
>> for the SMP support.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Dependency 3fd45a136ff61bb5 ("ARM: shmobile: rcar-gen2: Make sure
>> CNTVOFF is initialized on CA7/15") is part of v4.15-rc1.
>
> sorry if this is a bit of a sore topic but I'd like to ask what sort of
> testing this patch has seen. Are there any regressions in the area of
> CPU hotplug, suspend to RAM and so on...

Last time I tried, CPU hotplug worked fine (on Alt).
I cannot test suspend to RAM due to remote access.

Sergei?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
